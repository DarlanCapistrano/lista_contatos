import 'package:flutter/material.dart';
import 'package:contact_list/contatos/contato_controller.dart';
import 'package:contact_list/contatos/contatos_model.dart';

class ContatoPage extends StatefulWidget {
  const ContatoPage(this.contato, this.editando, {Key? key}) : super(key: key);
  final bool editando;
  final Contato contato;

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  final ContatoController _contatoController = ContatoController();

@override
  void initState() {
    _contatoController.initContatoPage(widget.contato);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.contato.nome ?? "Adicionar Contato"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _contatoController.clickAdicionarContato(context, widget.contato.id, widget.editando),
        child: const Icon(Icons.save),
      ),
      body: contatoBody(context),
    );
  }

  Widget contatoBody(BuildContext context){
    return Column(
      children: [
        const SizedBox(
          height: 150,
          width: 150,
          child: Icon(Icons.person, size: 150),
        ),
        textFieldItem(context, "Nome", _contatoController.textControllerNome),
        textFieldItem(context, "Email", _contatoController.textControllerEmail),
        textFieldItem(context, "Phone", _contatoController.textControllerPhone),
      ],
    );
  }

  Widget textFieldItem(BuildContext context, String label, TextEditingController textController){
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(label: Text(label)),
        controller: textController,
      ),
    );
  }
}