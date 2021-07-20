

import 'dart:convert';

import 'package:appmove/model/postModel.dart';
import 'package:http/http.dart' as Http;


class Api{
  static Future<Http.Response> getHashtagData() async {
    // print('getData');
  
    final responseData = await Http
        .get("https://today-api.moveforwardparty.org/api/main/content");
  
    return responseData;
  }


 static Future checkInternetConnectivity() async {
   print('checkInternetConnectivity');
 
  bool isConnected;
 
    
 
    isConnected = true;

  return isConnected;
}

static Future<String> createPost() async{
  //same as previous body
  String response="heool";
  return response;
}

  

}