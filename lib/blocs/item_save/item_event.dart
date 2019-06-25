import 'package:flutter_bloc/bloc_helpers/bloc_event_state.dart';
import 'package:meta/meta.dart';


class ItemDelete extends BlocEvent {

  final ItemEventType event;
  final String idItem;


  ItemDelete({
    @required this.event,
    @required this.idItem,
  });
}

class ItemSaveEvent extends BlocEvent {

  final ItemEventType event;
  final String nombre;
  final String idItemRepo;


  ItemSaveEvent({
    @required this.event,
    @required this.nombre,
    @required this.idItemRepo,
  });
}

enum ItemEventType {
  none,
  deletingItem,
  savingItem,
}