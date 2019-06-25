import 'package:flutter/material.dart';
import 'package:flutter_bloc/bloc_widgets/bloc_state_builder.dart';
import 'package:flutter_bloc/blocs/item/item_bloc.dart';
import 'package:flutter_bloc/blocs/item_save/item_save_bloc.dart';
import 'package:flutter_bloc/blocs/item_save/item_event.dart';
import 'package:flutter_bloc/blocs/item_save/item_state.dart';
import 'package:flutter_bloc/models/itemRepo.dart';
import 'package:flutter_bloc/pages/home_page.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  List<ItemRepo> _itemList;
  List<DropdownMenuItem<ItemRepo>> _ddItemList;
  ItemRepo _currentItemSelected;
  TextEditingController nameController = new TextEditingController();

  ItemSaveBloc _itemSaveBloc;

  @override
  void initState() {
    super.initState();
    _itemSaveBloc = ItemSaveBloc();
    bloc.fetchRepoName();
  }

  @override
  void dispose() {
    super.dispose();
    _itemSaveBloc?.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<ItemState>(
        bloc: _itemSaveBloc,
        builder: (BuildContext context, ItemState state) {
          if (state.isRunning) {
            return _buildNormal(context);
          } else if (state.isSuccess) {
            return _buildSuccess();
          } else if (state.isFailure) {
            return _buildFailure();
          }
          return _buildNormal(context);
        });
  }

  Widget _buildFailure() {
    return AlertDialog(
      title: Text('Error!'),
      content: const Text(
          'Error en creacion del item'),
      actions: <Widget>[
        FlatButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildNormal(BuildContext context) {
    return Container(
      child: Scaffold(
        body: StreamBuilder(
          stream: bloc.allItemsRepo,
          builder: (context, AsyncSnapshot<List<ItemRepo>> snapshot) {
            if (snapshot.hasData) {
              _itemList = snapshot.data;
              _ddItemList = buildDropDownMenuItems(_itemList);
              return showItem(context);
            } else if (snapshot.hasError) {
              return Text('Error es:${snapshot.error}');
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget showItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ListTile(
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                child: new Text(
                  "Agregar nuevo item",
                  style:
                      new TextStyle(fontSize: 30.0, color: Color(0xFF18D191)),
                ),
              )
            ],
          ),
        ),
        ListTile(
          title: Padding(
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Ingrese nombre del item",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
            padding: const EdgeInsets.all(15.0),
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                DropdownButton(
                  hint: Text('Elija una opcion'),
                  value: _currentItemSelected,
                  items: _ddItemList,
                  onChanged: (ItemRepo selectedItem) {
                    setState(() {
                      _currentItemSelected = selectedItem;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        ListTile(
          title: Padding(
            child: RaisedButton(
              child: Text("Agregar"),
              onPressed: () {
                addNewItem(
                    nameController.text, _currentItemSelected.idItemRepo);
              },
            ),
            padding: const EdgeInsets.all(15.0),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<ItemRepo>> buildDropDownMenuItems(List itemRepos) {
    List<DropdownMenuItem<ItemRepo>> items = List();
    for (ItemRepo itemRepo in itemRepos) {
      items.add(
        DropdownMenuItem(
          value: itemRepo,
          child: Text(itemRepo.descripcion),
        ),
      );
    }
    return items;
  }

  void addNewItem(name, item) async {
    if (name == "" || item == null) {
      return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button for close dialog!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error!'),
            content: const Text('Debe ingresar un nombre del item'),
            actions: <Widget>[
              FlatButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      _itemSaveBloc.emitEvent(ItemSaveEvent(
          event: ItemEventType.savingItem, nombre: name, idItemRepo: item));
    }
  }

  Widget _buildSuccess() {
    return AlertDialog(
      title: Text('Muy bien!'),
      content: Text(
          'Se creo ' + nameController.text),
      actions: <Widget>[
        FlatButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ],
    );
  }

}
