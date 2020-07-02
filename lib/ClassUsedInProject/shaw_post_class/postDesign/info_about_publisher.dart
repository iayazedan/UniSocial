import 'package:flutter/material.dart';

class PublisherInfo extends StatelessWidget {

  String studentName = "Khaled Sayed";
  String studentImagePath = "images/avatar.jpg";
  String yearAndSection = "Fourth Year CS : Section 2";

  PublisherInfo({this.studentName,this.studentImagePath,this.yearAndSection});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 45.0,
          width: 45.0,
          margin: EdgeInsets.only(
              left: 10.0, top: 10.0, right: 20.0),
          child: CircleAvatar(
            backgroundImage:
            AssetImage(studentImagePath),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(studentName,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  )),
              Container(
                margin: EdgeInsets.only(top: 2.0),
                child: Text(yearAndSection,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.pinkAccent.shade100,
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
