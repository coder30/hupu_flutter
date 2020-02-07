import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/data.dart';
import './newsCard.dart';

class Forum extends StatefulWidget {
  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  var items = [];

  var dataUtils = DataUtils();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    var result = await dataUtils.getNews();
    result = json.decode(result)['result']['data'];
    var arr = [];
    for(int i=0; i < result.length; i++) {
      if(result[i]['title'] != null) {
        arr.add(result[i]);
      }
    }
    setState(() {
      items = arr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return new Container(
          child: new newCard(news: items[index]),
          padding: EdgeInsets.fromLTRB(6, 4, 6, 10),
        );
      },
    );
  }
}