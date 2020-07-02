import 'package:flutter/material.dart';
import '../../ClassUsedInProject/shaw_post_class/other_functions.dart';
import '../../ClassUsedInProject/shaw_post_class/postDesign/info_about_publisher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../Secretary.dart';

class ShowComplaints extends StatefulWidget {
  @override
  _ShowComplaintsState createState() => _ShowComplaintsState();
}

class _ShowComplaintsState extends State<ShowComplaints> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  String url = 'http://uni-social.tk/api/v1/complaints';

  Future<List<ComplaintInfo>> _getQuestions() async {

    var response = await http.get(url);
    List dataFromApi = json.decode(response.body);

    List<ComplaintInfo> questionInfo= [];

    for(var item in dataFromApi){
      ComplaintInfo _questionInfo = new ComplaintInfo(
        complaintId:item["id"].toString(),
        content: item["content"],
        userId: item["user_id"].toString(),
        createdAt:item["created_at"].toString(),
      );
      questionInfo.add(_questionInfo);
    }
    return questionInfo;
  }

  @override
  void initState() {
    readdata();
    super.initState();
  }
  //----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar:AppBar(

        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) =>Secretary()));
        },),
        title: Text("Show Complaints", style: TextStyle(color: Colors.white,
        fontSize: 15),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),

      body: RefreshIndicator(
        onRefresh: _getQuestions,
        key: _refreshIndicatorKey,
        child: Container(
          child: FutureBuilder(
            future: _getQuestions(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.connectionState != ConnectionState.done){
                return Container(
                  child: Center(
                    child: Text("loading ..."),
                  ),
                );
              }else{
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context,int i){
                    return Card(
                        //margin: EdgeInsets.all(8),
                        child: Container(
                            color: Colors.white,
                            child: Column(
                                children: <Widget>[

                                  new Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: new PublisherInfo(
                                          yearAndSection: "First Year : Section 1",
                                          studentName: "Khaled Sayed",
                                          studentImagePath: "images/avatar.jpg",
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        child: new Text(
                                          getTimePost(snapshot.data[i].createdAt),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13.0,
                                              color: Colors.grey.shade500),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(16),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Text(
                                        snapshot.data[i].content,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18.0, color: Colors.black87),
                                      ),
                                    ),
                                  ),
                                ]
                            )
                        )
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ComplaintInfo{

  String complaintId;
  String content;
  String userId;
  String target;
  String createdAt;

  ComplaintInfo({this.content,this.userId,this.complaintId,this.target,this.createdAt});
}

String getTimePost(String datePost) {
  DateTime dateNow = new DateTime.now();

  int yearPOst = int.parse(datePost.toString().substring(0, 4).trim());
  int yearNow = int.parse(dateNow.toString().substring(0, 4).trim());
  int year = yearNow - yearPOst;

  int monthPost = int.parse(datePost.toString().substring(5, 7).trim());
  int monthNow = int.parse(dateNow.toString().substring(5, 7).trim());
  int month = monthNow - monthPost;

  int dayPost = int.parse(datePost.toString().substring(8, 10).trim());
  int dayNow = int.parse(dateNow.toString().substring(8, 10).trim());
  int day = dayNow - dayPost;

  int hourPost = int.parse(datePost.toString().substring(11, 13).trim());
  int hourNow = int.parse(dateNow.toString().substring(11, 13).trim());
  int hour = hourNow - hourPost - 2;

  if (year != 0) {
    return "since $yearPOst";
  } else{
    if (month != 0) {
      return "since $month month";
    } else{
      if (day != 0) {
        if(day==1) return "Yesterday";
        return "since $day day";
      } else{
        if (hour != 0) {
          return "Today\n since $hour hour";
        } else{
          return "Just Now";
        }
      }
    }
  }
}

void _getUserById(){

}