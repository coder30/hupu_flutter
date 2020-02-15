import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewCard extends StatelessWidget{
  NewCard({Key key, this.news}): super(key: key);
  var news = {};

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        children: <Widget>[
          Text(
            news['userName'],
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            news['title'],
            style: TextStyle(
              fontSize: 16
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start
      ),
    );
  }
}