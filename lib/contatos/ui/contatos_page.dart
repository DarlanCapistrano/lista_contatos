import 'package:flutter/material.dart';
import 'package:contact_list/contatos/contato_controller.dart';
import 'package:contact_list/contatos/contatos_model.dart';

class ContatosPage extends StatefulWidget {
  const ContatosPage({Key? key}) : super(key: key);

  @override
  State<ContatosPage> createState() => _ContatosPageState();
}

class _ContatosPageState extends State<ContatosPage> {
  final ContatoController _contatoController = ContatoController();

  @override
  void initState() {
    _contatoController.initContatosPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contatos"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _contatoController.goToContatoPage(context, false, Contato()),
        child: const Icon(Icons.add),
      ),
      body: streamContatos(context),
    );
  }

  Widget streamContatos(BuildContext context){
    return StreamBuilder<List<Contato>>(
      stream: _contatoController.controllerContatos.stream,
      initialData: const [],
      builder: (context, snapshot) => contatosList(context, snapshot.data!),
    );
  }

  Widget contatosList(BuildContext context, List<Contato> contatos){
    return ListView.builder(
      itemCount: contatos.length,
      itemBuilder: (context, index) => contatoItem(context, contatos[index]),
    );
  }

  Widget contatoItem(BuildContext context, Contato contato) {
    return GestureDetector(
      onTap: () => _contatoController.goToContatoPage(context, true, contato),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              const SizedBox(
                width: 80,
                height: 80,
                child: Icon(Icons.person),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contato.nome ?? "nome vazio", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    Text(contato.email ?? "email vazio", style: const TextStyle(fontSize: 18)),
                    Text(contato.phone ?? "phone vazio", style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}