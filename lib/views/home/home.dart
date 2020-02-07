import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hupu/views/home/topicCard.dart';
import '../../utils/data.dart';
import './newCard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var nid = 0;
  var items = [];
  var topicArr = [];
  var dataUtils = DataUtils();
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getData();
    _scrollController.addListener(listener);
  }

  listener() {
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _getMore();
    }
  }

  Future _getData() async {
    var result = await dataUtils.getNewsList();
    result = result['result']['data'];
    var newsArr = [];
    var topArr = [];
    for(int i=0; i < result.length; i++) {
      if(result[i]['title'] != null) {
        if(result[i]["is_top"] == '1') {
          topArr.add(result[i]);
        } else  {
          newsArr.add(result[i]);
        }
      }
    }
    nid = int.parse(newsArr[newsArr.length-1]['nid']);
    setState(() {
      items = newsArr;
      topicArr = topArr;
    });
  }

  Future _getMore() async {
    if(!isLoading) {
      isLoading = true;
      var result = await dataUtils.getNewsList(nid: nid);
      result = result['result']['data'];
      var arr = items;
      for(int i=0; i < result.length; i++) {
        if(result[i]['title'] != null) {
          arr.add(result[i]);
        }
      }
      nid = int.parse(arr[arr.length-1]['nid']);
      setState(() {
        items = arr;
      });
      isLoading = false;
    }
  }

  Widget _renderRow(context, index) {
    if(index < items.length) {
      if(index == 0) {
        return _getTopWidget();
      }
      return new Container(
        child: new NewsCard(news: items[index]),
        padding: EdgeInsets.fromLTRB(16, 4, 6, 10),
      );
    } else if(index > 0) {
      return _getLoadMoreWidget();
    }
    return null;
  }

  Widget _getTopWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Text('D R I B A L L', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TopCard(items: topicArr),
          _getNewsBabel(),
          new NewsCard(news: items[0]),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: EdgeInsets.fromLTRB(16, 8, 6, 10),
    );
  }

  Widget _getNewsBabel() {
    return Container(
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Container(
              height: 20,
              width: 4,
              color: Color(0xFF006BB5),
            )
          ),     
          Container(
            child:  Text('新闻', style: TextStyle(color: Color(0xFF006BB5), fontSize: 18, fontWeight: FontWeight.w600)),
            padding: EdgeInsets.only(left: 4),
          )     
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      padding: EdgeInsets.only(bottom: 12),
    );
  }

  Widget _getLoadMoreWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        children: <Widget>[
          Container(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(strokeWidth: 2)
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text('加载更多'),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getData,
      child: Column(
        children: <Widget>[
          SizedBox(height: 35),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Expanded(
              child: ListView.builder(
                itemCount: items.length+1,
                itemBuilder: _renderRow,
                controller: _scrollController,
              )
            ) 
          ) 
        ],
      ) 
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}