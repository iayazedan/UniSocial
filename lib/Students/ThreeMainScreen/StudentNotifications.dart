import 'package:flutter/material.dart';

class StudentNotifications extends StatefulWidget {
  @override
  _StudentNotificationsState createState() => _StudentNotificationsState();
}

class _StudentNotificationsState extends State<StudentNotifications> {

  List<Widget> myFunctionList() {
    List<Widget> listCard = new List<Widget>();
    for (int i = 0; i <= 10; i++) {
      listCard.add(
          new Card(
            child: new Container(
              height: 80.0,
              child: new Row(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new CircleAvatar(backgroundImage: AssetImage("images/avatar.jpg")),
                ),
                new Text(
                  " Elsayed liked your post ... ",
                  textDirection: TextDirection.ltr,
                ),
              ]),
            ),
          )
      );
    }
    return listCard;
    }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 2.0, right: 2.0),
      color: Colors.white30,
      child: ListView(
        children: <Widget>[
          Column(
            children: myFunctionList(),
          )
        ],
      ),
    );
  }
}