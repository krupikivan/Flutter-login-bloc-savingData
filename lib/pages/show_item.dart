import 'package:flutter/material.dart';
import 'package:flutter_bloc/bloc_widgets/bloc_state_builder.dart';
import 'package:flutter_bloc/blocs/item/item_bloc.dart';
import 'package:flutter_bloc/blocs/item_save/item_delete_bloc.dart';
import 'package:flutter_bloc/blocs/item_save/item_event.dart';
import 'package:flutter_bloc/blocs/item_save/item_state.dart';
import 'package:flutter_bloc/models/item.dart';
import 'package:flutter_bloc/pages/home_page.dart';

class ShowItem extends StatefulWidget {
  @override
  _ShowItemState createState() => _ShowItemState();
}

class _ShowItemState extends State<ShowItem> {

  ItemDeleteBloc _itemStateBloc;

  void initState() {
    super.initState();
    _itemStateBloc = ItemDeleteBloc();
    bloc.fetchAllItem();
  }

  @override
  void dispose() {
    super.dispose();
    _itemStateBloc?.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<ItemState>(
        bloc: _itemStateBloc,
        builder: (context, ItemState state) {
          if (state.isRunning) {
            return _buildNormal(context);
          } else if (state.isSuccess) {
            return _buildSuccess();
          } else if (state.isFailure) {
            return _buildFailure();
          }
          return _buildNormal(context);
        }
    );
  }

  Widget _buildNormal(BuildContext context) {
    return StreamBuilder<List<Item>>(
        stream: bloc.allItems,
        builder: (context, AsyncSnapshot<List<Item>> snapshot) {
          return snapshot.hasData
              ? buildList(snapshot)
              : new Center(child: new CircularProgressIndicator());
        });
  }

  Widget buildList(AsyncSnapshot<List<Item>> snapshot) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
        itemCount: snapshot.data.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return InkResponse(
            enableFeedback: true,
            child: Card(
             child: new Stack(
               children: <Widget>[
                 new Image.network(snapshot.data[index].uri, fit: BoxFit.cover),
                 Padding(padding: EdgeInsets.only(top: 150, left: 15), child: new Text(snapshot.data[index].nombre, style: new TextStyle(fontSize: 15.0, color: Color(0xFF18D191), fontWeight: FontWeight.bold))),
               ],
             ),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.all(18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
            ),
            onTap: () => deleteItem(snapshot.data[index]),
          );
        },
      );
  }

  deleteItem(Item item) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar listado'),
          content: Text(
              'Seguro quiere eliminar el item ' + item.nombre + '?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Si'),
              onPressed: () async {
                _deleteListById(item.idItem);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteListById(idItem) {
    _itemStateBloc.emitEvent(ItemDelete(
        event: ItemEventType.deletingItem,
        idItem: idItem
    ));
  }

  Widget _buildSuccess() {
    return AlertDialog(
      title: Text('Exitoso'),
      content: const Text('El item se ha eliminado con exito'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ],
    );
  }

  Widget _buildFailure() {
    return AlertDialog(
      title: Text('Error'),
      content: const Text('Error en la eliminacion del item'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

}