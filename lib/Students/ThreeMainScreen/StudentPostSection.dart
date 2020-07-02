import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/info_about_publisher.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/content_of_post.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/the_Reacts_in_post.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/other_functions.dart';


class StudentPostSection extends StatefulWidget {
  @override
  _StudentPostSectionState createState() => _StudentPostSectionState();
}
class _StudentPostSectionState extends State<StudentPostSection> {

  printit(String v){
    debugPrint("id post: "+v);
  }

  @override
  void initState() {
    readdata();
    this.makeRequest();
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  String url = 'http://uni-social.tk/api/v1/post?status=1&&yearandsection_id=$yearId';
  List dataFromApi;

  Future<String> makeRequest() async {
    try{
      var response = await http
          .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

      setState(() {
        var extractdata = json.decode(response.body);
        dataFromApi = extractdata;
      });
    }catch(e){}


  }

  //----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: makeRequest,
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
                      //colorLike: getPostLikeColor(dataFromApi[i]['like']),
                      listLikes: dataFromApi[i]['like'],
                      listComments: dataFromApi[i]["postcomment"],
                      //numberOfLikes: getNumberOfLikes(dataFromApi[i]['like']),
                      //numberOfComments:getNumberOfComments(dataFromApi[i]["postcomment"]),
                      timeOfPost: getTimePost(dataFromApi[i]['created_at']),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}