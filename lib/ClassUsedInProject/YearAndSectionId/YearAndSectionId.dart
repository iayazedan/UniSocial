import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String _url = "http://www.uni-social.tk/api/v1/yearandsection";
List lYASId;

 List<int> firstYearSectionsId = [0,0,0,0];
 List<int> secondYearSectionsId = [0,0,0,0];
 List<int> thirdYearSectionsId = [0,0,0,0];
 List<int> forthYearSectionsId = [0,0,0,0];

Future makeRequestForYASId() async {
  try{
    var response = await http.get(Uri.encodeFull(_url),
        headers: {"Accept": "application/json"});
    lYASId = json.decode(response.body);
    await setYASId();
  }catch(e){
    debugPrint("error in makeRequest"+e.toString());
  }

}

Future setYASId()async{
  for(var item in lYASId) {
    if (item["name"] == "First Year") {
      if (item["sectionnumber"] == "One") firstYearSectionsId[0] = item["id"];
      else if (item["sectionnumber"] == "Two") firstYearSectionsId[1] = item["id"];
      else if (item["sectionnumber"] == "Three") firstYearSectionsId[2] = item["id"];
      else if (item["sectionnumber"] == "Four") firstYearSectionsId[3] = item["id"];
    }
    else if (item["name"] == "Second Year") {
      if(item["sectionnumber"] == "One") secondYearSectionsId[0] = item["id"];
      else if(item["sectionnumber"] == "Two") secondYearSectionsId[1] = item["id"];
      else if(item["sectionnumber"] == "Three") secondYearSectionsId[2] = item["id"];
      else if(item["sectionnumber"] == "Four") secondYearSectionsId[3] = item["id"];
    }
    else if(item["name"] == "Three Year"){
      if(item["sectionnumber"] == "One CS") thirdYearSectionsId[0] = item["id"];
      else if(item["sectionnumber"] == "Two CS") thirdYearSectionsId[1] = item["id"];
      else if(item["sectionnumber"] == "Three CS") thirdYearSectionsId[2] = item["id"];
      else if(item["sectionnumber"] == "Four CS") thirdYearSectionsId[3] = item["id"];

      else if(item["sectionnumber"] == "One IS") thirdYearSectionsId[4] = item["id"];
      else if(item["sectionnumber"] == "Two IS") thirdYearSectionsId[5] = item["id"];
      else if(item["sectionnumber"] == "Three IS") thirdYearSectionsId[6] = item["id"];
      else if(item["sectionnumber"] == "Four IS") thirdYearSectionsId[7] = item["id"];
    }
    else if(item["name"] == "Four Year"){
      if(item["sectionnumber"] == "One CS") forthYearSectionsId[0] = item["id"];
      else if(item["sectionnumber"] == "Two CS") forthYearSectionsId[1] = item["id"];
      else if(item["sectionnumber"] == "Three CS") forthYearSectionsId[2] = item["id"];
      else if(item["sectionnumber"] == "Four CS") forthYearSectionsId[3] = item["id"];

      else if(item["sectionnumber"] == "One IS") forthYearSectionsId[4] = item["id"];
      else if(item["sectionnumber"] == "Two IS") forthYearSectionsId[5] = item["id"];
      else if(item["sectionnumber"] == "Three IS") forthYearSectionsId[6] = item["id"];
      else if(item["sectionnumber"] == "Four IS") forthYearSectionsId[7] = item["id"];
    }
  }
}
