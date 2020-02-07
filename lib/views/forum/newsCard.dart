import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class newCard extends StatelessWidget{
  newCard({Key key, this.news}): super(key: key);
  var news = {};

  @override
  Widget build(BuildContext context) {
    print(news);
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