import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './newsDetail.dart';

class NewsCard extends StatelessWidget{
  NewsCard({Key key, this.news}): super(key: key);
  var news = {};

  _jumpToNews(BuildContext context, String id) {
    Navigator.push(context, MaterialPageRoute(
       builder: (context)=> NewsDetail(id: id)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: ()=>_jumpToNews(context, news['link'].substring(19,27)),
      child: new Container(
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
              Image.network(
                news['img'],
                width: 100,
                height: 80,
                fit: BoxFit.cover
              ),
            ),
            Expanded(child: 
              Container(
                child: Text(
                  news['title'],
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              )
              
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}