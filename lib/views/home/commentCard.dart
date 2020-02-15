import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CommentCard extends StatelessWidget{
  CommentCard({Key key, this.comment}): super(key: key);
  var comment = {};
  @override 

  Widget _getAvatar(imgUrl) {
    return(
      Container(
       child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          imgUrl,
          width: 30,
          height: 30,
          fit: BoxFit.cover
        ),
       ),
       padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
      )
    );
  }

  Widget _getContent(content) {
    print(content);
    content = content.replaceAll("data-origin", "src");
    content = content.replaceAll("data-gif", "src");
    return (
      Container(
        child: Html(
          data: content,
          defaultTextStyle: TextStyle(fontSize: 18, height: 1.5),
        ),
        padding: EdgeInsets.only(top: 10),
      )
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          _getAvatar(comment['userImg']),
          Flexible(
            child: Column(
            children: <Widget>[
             Text(comment['userName']),
             Text(comment['time'], style: TextStyle(fontSize: 12)),
             _getContent(comment['content'])
            ], 
            crossAxisAlignment: CrossAxisAlignment.start,
          ))
        ],
        crossAxisAlignment:  CrossAxisAlignment.start,
      ),
      padding: EdgeInsets.all(10),
    );
  }
}