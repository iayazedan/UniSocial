import 'package:flutter/material.dart';

class ContentPost extends StatelessWidget {

  String postContent;
  String imagePostPath=""; //"images/sec.jpg"
  ContentPost({this.postContent,this.imagePostPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: Text(
              postContent,//data[i]['content'],
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 14.0, color: Colors.black87),
            ),
          ),
          new Image(
            image: AssetImage(imagePostPath),
          )
        ],
      ),
    );
  }
}
