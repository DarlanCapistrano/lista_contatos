class Contato {
  final int? id;
  final String? nome;
  final String? email;
  final String? phone;

  Contato({this.id, this.nome, this.email, this.phone});

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
      id: map["id"],
      nome: map["nome"],
      email: map["email"],
      phone: map["phone"],
    );
  }

  static fromMapList(List<Map<String, dynamic>> contatos){
    return contatos.map((e) => Contato.fromMap(e)).toList();
  }
}