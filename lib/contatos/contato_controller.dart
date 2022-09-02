import 'package:flutter/material.dart';
import 'package:contact_list/contatos/contatos_model.dart';
import 'package:contact_list/contatos/contatos_repository.dart';
import 'package:contact_list/contatos/ui/contato_page.dart';
import 'package:rxdart/subjects.dart';

class ContatoController{

  final ContatoRepository _contatoRepository = ContatoRepository();

  final TextEditingController textControllerNome = TextEditingController();
  final TextEditingController textControllerEmail = TextEditingController();
  final TextEditingController textControllerPhone = TextEditingController();

  final BehaviorSubject<List<Contato>> controllerContatos = BehaviorSubject<List<Contato>>();

  Future<void> initContatosPage() async {
    await _contatoRepository.initDb();
    var contatos = await _contatoRepository.findAllContatos();
    controllerContatos.sink.add(contatos);
  }

  Future<void> initContatoPage(Contato contato) async {
    await _contatoRepository.initDb();
    textControllerNome.text = contato.nome ?? "";
    textControllerEmail.text = contato.email ?? "";
    textControllerPhone.text = contato.phone ?? "";
  }

  Future<void> goToContatoPage(BuildContext context, bool editando, Contato contato) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => ContatoPage(contato, editando)));
    var contatos = await _contatoRepository.findAllContatos();
    controllerContatos.sink.add(contatos);
  }

  Future<void> clickAdicionarContato(BuildContext context, int? contatoId, bool editando) async {
    if(editando){
      await _contatoRepository.updateContato(contatoId, textControllerNome.text, textControllerEmail.text, textControllerPhone.text);
    } else{
      await _contatoRepository.insertContato(textControllerNome.text, textControllerEmail.text, textControllerPhone.text);
    }
    Navigator.pop(context);
  }
}