import 'package:flutter/material.dart';
import 'package:hupu/utils/data.dart';
import 'package:hupu/views/home/commentCard.dart';

class CommentList extends StatefulWidget {
  var id = '';
  CommentList({Key key, this.id}): super(key: key);
  @override
  _CommentList createState() => _CommentList();
}

class _CommentList extends State<CommentList> {
  var items = [];
  var dataUtils = DataUtils();
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async {
    var result = await dataUtils.getLightCommentList(tid: widget.id);
    result = result['data']['list'];
    print(result);
    setState(() {
      items = result;
    });
  }

  Widget _renderRow(context, index) {
    var item = items[index];
    return CommentCard(comment: item);
  }

  @override
  Widget build(BuildContext context) {
    return(
      ListView.builder(
        itemCount: items.length,
        itemBuilder: _renderRow,
        shrinkWrap: true, 
        physics: new NeverScrollableScrollPhysics(),
      )
    );
       
  }
}