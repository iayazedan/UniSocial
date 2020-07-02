import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../ClassUsedInProject/shaw_post_class/other_functions.dart';
import '../../ClassUsedInProject/YearAndSectionId/YearAndSectionId.dart';
import '../student.dart';
import '../../ClassUsedInProject/read_image/asset_thumb.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../../ClassUsedInProject/FunctionHelper/FunctionHelper.dart';
import '../../ClassUsedInProject/upload Images/Uploading images.dart';


class writepost extends StatefulWidget {
  @override
  _writepostState createState() => _writepostState();
}

class _writepostState extends State<writepost> {


  String _error = 'No Error Dectected';
  List<Asset> images = List<Asset>();
  List<String> imageNameInServer = new List<String>();

  //function select image
  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
      );
    } on PlatformException catch (e) {
      error = e.message;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }
  //show image select
  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 5,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 100,
          height: 100,
        );
      }),
    );
  }


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _postcontroller = new TextEditingController();
  bool _checkSec = false;
  bool _checkYear = false;
  String addPostUrl = "http://uni-social.tk/api/v1/post/addmult";
  //String addPostUrl = "http://uni-social.tk/api/v1/post/add";

  @override
  void initState() {
    super.initState();
    readdata();
  }
  @override
  void dispose() {
    _postcontroller.dispose();
    super.dispose();
  }

  Future publishPost()async{

    if((_postcontroller.text.isNotEmpty || images.length != 0)&&
        (_checkSec || _checkYear)) {
      if (images.length != 0) {
        if(imageNameInServer.length==0){
          showInSnackBar(context, "uploading image ...", scaffoldKey: _scaffoldKey);
          imageNameInServer = await uploadingImages(images, context);
        }
      }
      var response = await http.post(addPostUrl, body: {
        "content":_postcontroller.text,
        "user_id": userId,
        "status": "0",
        "image": json.encode(imageNameInServer),
        "yearandsection_id":_checkSec==true?json.encode([yearId])
            :json.encode([yearId]),//update needed
      });

      if(response.statusCode ==200)
        showSuccessDialog(context, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Student()));
      }, "Your Post Wait To Accepted");
      else print(response.statusCode);
    }
    else showInSnackBar(context, "please fill your data", scaffoldKey: _scaffoldKey);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          InkWell(child:
          Icon(Icons.share,color: Colors.black,),
            onTap: (){
              publishPost();
            },
          )
        ],
        title: Text("Publish Post",style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontStyle: FontStyle.italic,
        ),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        shrinkWrap: true,
        //padding: const EdgeInsets.all(.0),
        children: <Widget>[
          Card(
              color: Colors.white,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 5),
                child: Row(children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: 40,
                        height: 40,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("images/avatar.jpg"),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: loadAssets,
                      child: Icon(Icons.photo_size_select_actual,size: 30,
                        color: Colors.blue,)
                    ),
                  ),
                ]),
              )
          ),
          Container(
            margin: EdgeInsets.only(top: 8,left: 3,right: 3),
            child: Column(
              children: <Widget>[
                TextFormField(

                  controller: _postcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)
                      ),
                      filled: true,
                      hintText: "Write your Post",
                      labelText: "Type Here"),
                  textCapitalization: TextCapitalization.words,
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18, color: Colors.black),

                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: images.length == 0
                      ?Text("")
                      :Container(
                    padding: EdgeInsets.all(3),
                    constraints:
                    BoxConstraints.expand(
                        width: MediaQuery.of(context).size.width, height: 150),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)),
                      border: Border.all(
                          color: Colors.grey.shade600,
                          width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child:buildGridView(),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Publish For My Section", style: TextStyle(fontSize: 16),),
                          Checkbox(
                            onChanged: (bool value) {
                              setState(() => this._checkSec = value);
                              }, value: this._checkSec,),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Publish For My Group", style: TextStyle(fontSize: 16),),
                          Checkbox(
                            onChanged: (bool value) {
                              setState(() => this._checkYear = value);
                            }, value: this._checkYear,),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
