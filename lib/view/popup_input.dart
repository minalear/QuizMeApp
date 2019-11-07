import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

Future<Tuple2<String, bool>> showInputDialog(BuildContext context, String title, String hintText) async {
  String userInput = '';
  return showDialog<Tuple2<String, bool>>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: hintText,
                ),
                onChanged: (value) => userInput = value,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          RaisedButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(Tuple2<String, bool>(userInput, true)),
          ),
          RaisedButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(Tuple2<String, bool>(userInput, false)),
          ),
        ],
      );
    }
  );
}