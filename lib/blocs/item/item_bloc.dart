import 'package:flutter_bloc/models/item.dart';
import 'package:flutter_bloc/models/itemRepo.dart';
import 'package:flutter_bloc/repos/item_repository.dart';
import 'package:rxdart/rxdart.dart';

class ItemBloc {
  final _repository = ItemRepository();
  final _itemFetcher = PublishSubject<List<Item>>();
  final _repoFetcher = PublishSubject<List<ItemRepo>>();

  Observable<List<Item>> get allItems => _itemFetcher.stream;
  Observable<List<ItemRepo>> get allItemsRepo => _repoFetcher.stream;


  fetchAllItem() async {
    List<Item> item = await _repository.fetchAllItem();
    _itemFetcher.sink.add(item);
  }

  fetchRepoName() async {
    List<ItemRepo> itemRepo = await _repository.fetchAllRepo();
    _repoFetcher.sink.add(itemRepo);
  }

  dispose() async{
    await _itemFetcher.drain();
    _itemFetcher.close();
    await _repoFetcher.drain();
    _repoFetcher.close();
  }
}

final bloc = ItemBloc();
