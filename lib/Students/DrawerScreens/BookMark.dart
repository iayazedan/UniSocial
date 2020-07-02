import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../ClassUsedInProject/shaw_post_class/postDesign/info_about_publisher.dart';
import '../../ClassUsedInProject/shaw_post_class/postDesign/content_of_post.dart';
import '../../ClassUsedInProject/shaw_post_class/postDesign/the_Reacts_in_post.dart';
import '../../ClassUsedInProject/shaw_post_class/other_functions.dart';
import '../../ClassUsedInProject/shaw_post_class/PostInfo/PostInfo.dart';
import 'dart:async';

class BookMark extends StatefulWidget {
  @override
  _BookMarkState createState() => _BookMarkState();
}
class _BookMarkState extends State<BookMark> {

  Color savedColor=Colors.black;


  @override
  void initState() {
    readdata();
    this._getSavedPosts();
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  String url = 'http://uni-social.tk/api/v1/seved';
  List dataFromApi=[];
  List postData;

  Future<void> _getSavedPosts() async {

    var response = await http.get(url);
    postData = json.decode(response.body);

    for(int i=0;i<postData.length;i++){
      dataFromApi.add(postData[i]["post"]);
    }
  }
  //----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Save post",style: TextStyle(fontSize: 16,color: Colors.black),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body:RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _getSavedPosts,
        child: ListView.builder(
          itemCount: dataFromApi == null ? 0 : dataFromApi.length,
          padding: const EdgeInsets.all(5.0),
          itemBuilder: (BuildContext context, i) {
            return dataFromApi[i]["status"] == 0
                ? Text("")
                : Card(
                margin: EdgeInsets.only(bottom: 7.0),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      //------------------------- top design -------------------------

                      new PublisherInfo(
                        yearAndSection: "First Year : Section 1",
                        studentName: "Khaled Sayed",
                        studentImagePath: "images/avatar.jpg",
                      ),

                      //--------------------- content post ---------------------

                      new ContentPost(
                        postContent: dataFromApi[i]["content"],
                        imagePostPath: "images/sec.jpg",
                      ),

                      //--------------------- reacts post ---------------------

                      new Reacts(
                        userId: userId,
                        postId: dataFromApi[i]['id'].toString(),
                        listLikes: dataFromApi[i]['like'],
                        listComments: dataFromApi[i]["postcomment"],
                        timeOfPost: getTimePost(dataFromApi[i]['created_at']),
                      ),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}