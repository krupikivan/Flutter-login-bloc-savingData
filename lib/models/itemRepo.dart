
import 'dart:convert';

List<ItemRepo> ItemRepoFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<ItemRepo>.from(jsonData.map((x) => ItemRepo.fromJson(x)));
}

String ItemRepoToJson(List<ItemRepo> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class ItemRepo {
  String idItemRepo;
  String descripcion;

  ItemRepo({
    this.idItemRepo,
    this.descripcion,
  });

  factory ItemRepo.fromJson(Map<String, dynamic> json) {
    return new ItemRepo(
      idItemRepo: json["idItemRepo"] as String,
      descripcion: json["descripcion"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "idItemRepo": idItemRepo,
    "descripcion": descripcion,
  };
}
