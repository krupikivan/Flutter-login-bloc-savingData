

import 'package:flutter_bloc/bloc_helpers/bloc_event_state.dart';

class ItemState extends BlocState {
  ItemState({
    this.isRunning: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.isSavingItem: false,
  });

  final bool isRunning;
  final bool isSuccess;
  final bool isFailure;
  final bool isSavingItem;

  factory ItemState.noAction() {
    return ItemState();
  }

  factory ItemState.running(){
    return ItemState(isRunning: true,);
  }

  factory ItemState.savingItem(){
    return ItemState(isSavingItem: true,);
  }

  factory ItemState.success(){
    return ItemState(isSuccess: true,);
  }

  factory ItemState.failure(){
    return ItemState(isFailure: true,);
  }

}