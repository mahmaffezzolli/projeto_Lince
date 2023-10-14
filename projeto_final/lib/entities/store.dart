class Store {
  final int? id;
  String cnpj;
  String name;
  final String? password;
   String? autonomy;

  Store({
    this.id,
    required this.cnpj,
    required this.name,
    this.password,
    this.autonomy,
  });
}
