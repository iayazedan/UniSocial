import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../../ClassUsedInProject/shaw_post_class/postDesign/content_of_post.dart';
import '../../../ClassUsedInProject/shaw_post_class/postDesign/info_about_publisher.dart';
import '../../../ClassUsedInProject/shaw_post_class/postDesign/the_Reacts_in_post.dart';
import '../../../ClassUsedInProject/shaw_post_class/other_functions.dart';
import '../../../ClassUsedInProject/SaveDropDownSelection/Globalstate.dart';

enum IndicatorType { overscroll, refresh }

class year extends StatefulWidget {
  @override
  _yearState createState() => _yearState();
}
class _yearState extends State<year> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  String url = 'http://uni-social.tk/api/v1/post?status=1';
  List dataFromApi;

  Future makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      dataFromApi = json.decode(response.body);
    });
  }
  @override
  void initState() {
    readdata();
    this.makeRequest();
    super.initState();
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
          return Card(
                  margin: EdgeInsets.only(bottom: 7.0),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        //--------------------- top design ---------------------

                        new PublisherInfo(
                          studentImagePath: "images/avatar.jpg",
                          studentName: "Khaled Sayed",
                          yearAndSection: "First Year : Section 2",
                        ),

                        //--------------------- content post -------------------

                        new ContentPost(
                          postContent: dataFromApi[i]['content'],
                          imagePostPath: "images/sec.jpg",
                        ),

                        //--------------------- Reacts post --------------------

                        new Reacts(
                          userId: userId,
                          postId: dataFromApi[i]['id'].toString(),
                          listLikes: dataFromApi[i]['like'],
                          listComments: dataFromApi[i]["postcomment"],
                          timeOfPost: getTimePost(dataFromApi[i]['created_at']),
                        ),
                      ],
                    ),
                  )
          );
        },
      ),
    );
  }
}
