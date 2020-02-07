import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/data.dart';

class NewsDetail extends StatefulWidget {
  NewsDetail({Key key, this.id}): super(key: key);
  var id = '';
  
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  var dataUtils = DataUtils();
  var title = '';
  var content = '';

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async{
    var result =  await dataUtils.getNewsDetail(id: widget.id);
    print(result);
    var _title = result['title'];
    var _content = result['offline_data']['data']['content'];
    var index = _content.indexOf('来源');
    if(index!=-1) {
      _content = _content.substring(0, index);
    }
    _content = _content.replaceAll("data-origin", "src");
    _content = _content.replaceAll("data-gif", "src");

    print(title);
    print(_content);
    setState(() {
      title= _title;
      content= _content;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(title);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify
            ),
            padding: EdgeInsets.all(10),
          ),
          Html(
            data:content,
            padding: EdgeInsets.all(10),
            defaultTextStyle: TextStyle(fontSize: 18, height: 1.5),
            onLinkTap: (url)async {
              url = url.substring(10);
              if(await canLaunch(url)) {
                await launch(url);
              } else {
                print(url);
              }
            },
          )
        ]
      )
    );
  }
}
