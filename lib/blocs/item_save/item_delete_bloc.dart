import 'dart:async';
import 'package:flutter_bloc/bloc_helpers/bloc_event_state.dart';
import 'package:flutter_bloc/blocs/item_save/item_event.dart';
import 'package:flutter_bloc/blocs/item_save/item_state.dart';
import 'package:flutter_bloc/repos/item_provider.dart';

class ItemDeleteBloc extends BlocEventStateBase<ItemDelete, ItemState> {


  ItemDeleteBloc()
      : super(
          initialState: ItemState.noAction(),
        );

  @override
  Stream<ItemState> eventHandler(ItemDelete event, ItemState currentState) async* {
    if (event.event == ItemEventType.deletingItem){
      yield ItemState.running();


      ItemProvider itemProvider = new ItemProvider();
      try{

        await itemProvider.deleteItem(
            idItem: event.idItem,
        );
      }catch (error) {
        yield ItemState.failure();
      }

      await Future.delayed(const Duration(seconds: 1));

      yield ItemState.success();
    }
  }
}