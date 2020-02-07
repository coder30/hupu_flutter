import 'package:flutter/cupertino.dart';

class TopCard extends StatelessWidget {
  TopCard({Key key, this.items}): super(key: key);
  var items = [];

  @override
  Widget build(BuildContext context) {
    print(items);
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: _renderRow,
      ),
    ) ;
  }

  Widget _renderRow(context, index) {
    return Stack(
      children: <Widget>[
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              items[index]['img'],
              width: 340,
              height: 190,
              fit: BoxFit.cover
            ),
          ),
          padding: EdgeInsets.fromLTRB(0, 16, 10, 10),
        ),
        Positioned(
          child: Text(
            items[index]['title'],
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
            softWrap: true,
          ),
          bottom: 20,
          left: 16,
          width: 300,
        )
      ],
    );
  }
}