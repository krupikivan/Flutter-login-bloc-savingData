import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/connection.dart';
import 'package:flutter_bloc/models/item.dart';
import 'package:flutter_bloc/models/itemRepo.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ItemProvider {

  Item item = Item();
  ItemRepo itemRepo = ItemRepo();

  final _urlRI = 'http://'+con.getUrl()+'/readItem.php';
  final _urlRIR = 'http://'+con.getUrl()+'/readItemRepo.php';
  final _urlAdd = 'http://'+con.getUrl()+'/insertItem.php';
  final _urlDel = 'http://'+con.getUrl()+'/deleteItem.php';

  Future<List<Item>> fetchItemList() async {
    final response = await http.get(_urlRI);
    if (response.statusCode == 200) {
      print(response.body);
      return compute(itemFromJson, response.body);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<ItemRepo>> fetchRepoList() async {
    final response = await http.get(_urlRIR);
    if (response.statusCode == 200) {
      print(response.body);
      return compute(ItemRepoFromJson, response.body);
    } else {
      throw Exception('Error');
    }
  }

  Future<bool> addItem(nombre, idItemRepo) async {
    var body = {'nombre': nombre, 'idItemRepo': idItemRepo};
    await Future.delayed(Duration(seconds: 1));
    final response = await http.post(_urlAdd, body: jsonEncode(body));
    if (response.statusCode == 400) {
      return false;
    } return true;
  }

  Future<bool> deleteItem({
    @required String idItem,
  }) async {

    await Future.delayed(Duration(seconds: 1));
    final response = await http.post(_urlDel+"?idItem=$idItem");
    if (response.statusCode == 400) {
      return false;
    }
    return true;
  }

}

