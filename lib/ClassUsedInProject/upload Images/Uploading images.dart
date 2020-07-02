import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart'as path;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';


Future<List<String>> uploadingImages(List<Asset> mySelectedImages,
    BuildContext context) async {

  List<String> imageNameFromServer = new List<String>();
  Uri uri = Uri.parse("http://uni-social.tk/img.php");

  for(Asset image in mySelectedImages){

    http.MultipartRequest request = http.MultipartRequest("POST", uri);
    ByteData byteData = await image.requestOriginal();
    List<int> imageData = byteData.buffer.asUint8List();

    http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
      'file_upload', imageData,
      filename: image.name,
      contentType: MediaType("image", "jpg"),
    );

    request.files.add(multipartFile);

    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) {
      imageNameFromServer.add(value);
    });
  }
  return imageNameFromServer;
}
