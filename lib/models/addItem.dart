
class NewItem {
  String nombre;
  String idItemRepo;

  NewItem({
    this.nombre,
    this.idItemRepo,
  });

  factory NewItem.fromJson(Map<String, dynamic> json) {
    return new NewItem(
      nombre: json["nombre"] as String,
      idItemRepo: json["idItemRepo"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "idItemRepo": idItemRepo,
  };
}
