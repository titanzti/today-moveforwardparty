
import 'dart:convert';

import 'package:appmove/model/testmoel.dart';
import 'package:http/http.dart' as Http;


class Api  {
 static Future<MessageDogsDao> randomDog() async {
    var url = "https://dog.ceo/api/breeds/image/random";
    var response = await Http.get(url);
    Map map = jsonDecode(response.body);
    MessageDogsDao msg = MessageDogsDao.fromJson(map);
    print("URL image = " + msg?.message);
    return msg;
  }
}

 