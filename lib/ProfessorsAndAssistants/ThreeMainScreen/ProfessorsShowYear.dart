import 'package:flutter/material.dart';
import '../ThreeMainScreen/ScreenshowPostHelper/YearPostDesign.dart' as post;
import 'ScreenshowPostHelper/DropDown.dart';

class Year extends StatefulWidget {
  @override
  _YearState createState() => _YearState();
}

class _YearState extends State<Year> {

  @override
  initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Column(
        children: <Widget>[

          new MainDropDown(
            keyValue: "year",
            mDropValue1: "First Year",
            mDropValue2: "Second Year",
            mDropValue3: "Third Year",
            mDropValue4: "Forth Year",
            myFunction: (){},
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 2.0, right: 2.0),
              color: Colors.white,
              child: post.year(),
            ),
          ),
        ],
      ),
    );
  }
}
