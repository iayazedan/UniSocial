import 'package:flutter/material.dart';
import 'package:unisocial/ProfessorsAndAssistants/ThreeMainScreen/ScreenshowPostHelper/SectionPostDesign.dart' as post;
import './../../ClassUsedInProject/SaveDropDownSelection/Globalstate.dart';
import 'ScreenshowPostHelper/DropDown.dart';
class Section extends StatefulWidget {
  @override
  _SectionState createState() => _SectionState();
}
class _SectionState extends State<Section> {

  GlobalState _store = GlobalState.instance;
  String mySelectedSection;

  @override
  initState(){
    setSection();
    super.initState();
  }

  setSection(){
    if(_store.get('section')!=null){
      setState(() {
        mySelectedSection=_store.get('section');
      });
    }else{
      setState(() {
        mySelectedSection= "Section 1";
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Column(
        children: <Widget>[

          new MainDropDown(
            keyValue: "section",
            mDropValue1: "Section 1",
            mDropValue2: "Section 2",
            mDropValue3: "Section 3",
            mDropValue4: "Section 4",
            myFunction: setSection,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: post.section(),
            ),
          ),
        ],
      ),
    );
  }
}
