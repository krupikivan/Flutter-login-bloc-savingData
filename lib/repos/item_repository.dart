import 'dart:async';
import 'package:flutter_bloc/models/item.dart';
import 'package:flutter_bloc/models/itemRepo.dart';
import 'item_provider.dart';

class ItemRepository{

  final itemProvider = ItemProvider();

  Future<List<Item>> fetchAllItem() => itemProvider.fetchItemList();
  Future<List<ItemRepo>> fetchAllRepo() => itemProvider.fetchRepoList();

//---------------PROMOCION------------------------------------------

}