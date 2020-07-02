import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/info_about_publisher.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/postDesign/content_of_post.dart';
import 'package:unisocial/ClassUsedInProject/shaw_post_class/other_functions.dart';
import '../../ClassUsedInProject/shaw_post_class/PostInfo/PostInfo.dart';

class PostersNotifications extends StatefulWidget {
  @override
  _PostersNotificationsState createState() => _PostersNotificationsState();
}

class _PostersNotificationsState extends State<PostersNotifications> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  String url = 'http://www.uni-social.tk/api/v1/posters';

  Future<List<PostInfo>> _getPosts() async {

    var response = await http.get(url);
    List dataFromApi = json.decode(response.body);

    List<PostInfo> postInfo= [];

    for(var item in dataFromApi){
      PostInfo _postInfo = new PostInfo(
        //userId: item["user_id"].toString(),
        postId: item["id"].toString(),
        content: item["content"].toString(),
        createdAt: item["created_at"].toString(),
        //status: item["status"].toString(),
        //yearAndSectionId: item["yearandsection_id"].toString(),
        //postLike: item["like"],
        //postComment: item["postcomment"],
      );
      postInfo.add(_postInfo);
    }
    print(postInfo.length);
    return postInfo;
  }

  @override
  void initState() {
    readdata();
    super.initState();
  }
  //----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getPosts,
      key: _refreshIndicatorKey,
      child: Container(
        child: FutureBuilder(
          future: _getPosts(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.connectionState != ConnectionState.done){
              return Container(
                child: Center(
                  child: Text("loading ..."),
                ),
              );
            }else{
              return ListView.builder(
                itemCount: snapshot.data.length==null?0:snapshot.data.length,
                itemBuilder: (BuildContext context,int i){
                  return Card(
                      margin: EdgeInsets.only(bottom: 7.0),
                      child: Container(
                          color: Colors.white,
                          child: Column(
                              children: <Widget>[

                                Container(

                                  child: Row(
                                    children: <Widget>[

                                      new PublisherInfo(
                                        yearAndSection: "Secretary",
                                        studentName: "Khaled Sayed",
                                        studentImagePath: "images/avatar.jpg",
                                      ),
                                    ],
                                  ),
                                ),

                                new ContentPost(
                                  postContent: snapshot.data[i].content,
                                  imagePostPath: "images/sec.jpg",
                                ),

                                Container(
                                  padding: EdgeInsets.only(top: 16,bottom: 16,right: 32),
                                  alignment: Alignment.bottomRight,
                                  child: new Text(
                                    getTimePost(snapshot.data[i].createdAt),
                                    style: TextStyle(fontSize: 16,color: Colors.grey),
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
    );
  }
}