
import 'dart:convert';

List<Item> itemFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Item>.from(jsonData.map((x) => Item.fromJson(x)));
}

String itemToJson(List<Item> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Item {
  String idItem;
  String nombre;
  String uri;

  Item({
    this.idItem,
    this.nombre,
    this.uri,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return new Item(
      idItem: json["idItem"] as String,
      nombre: json["nombre"] as String,
      uri: json["uri"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "idItem": idItem,
    "nombre": nombre,
    "uri": uri,
  };
}
