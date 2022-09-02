import 'package:contact_list/contatos/contatos_model.dart';
import 'package:contact_list/db/database_provider.dart';
import 'package:sqflite/sqlite_api.dart';

class ContatoRepository{
  late final Database _database;

  Future<void> initDb() async {
    _database = await DBProvider.db.database;
  }

  Future<List<Contato>> findAllContatos() async {
    var contatosMap = await _database.rawQuery("SELECT * FROM contato");
    return Contato.fromMapList(contatosMap);
  }

  Future<void> insertContato(String nome, String email, String phone) async {
    await _database.insert("contato", {
      "nome": nome,
      "email": email,
      "phone": phone,
    });
  }

  Future<void> updateContato(int? contatoId, String nome, String email, String phone) async {
    await _database.rawUpdate("UPDATE contato SET nome = '$nome', email = '$email', phone = '$phone' WHERE id = $contatoId");
  }
}