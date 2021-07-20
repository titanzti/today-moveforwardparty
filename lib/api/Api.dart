import 'dart:convert';

import 'package:appmove/model/postlistSSmodel.dart';
import 'package:appmove/model/searchhastag.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as Http;
import 'package:appmove/model/postModel.dart';

class Api {
  static Future logout() async {
    print('Calllogout');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await SharedPreferences.getInstance();
    await preferences.remove("token");
    var clear = await preferences.clear();
    preferences?.setBool("isLoggedIn", false);
    preferences?.setString("token", "");
    print("!remover secc");

    return clear;
  }

  static Future gettoke() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenname = prefs.getString('token');
    return tokenname;
  }

   static Future getmyuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var myuid = prefs.getString('myuid');
    return myuid;
  }

  static Future<Http.Response> getHashtagData() async {
    // print('getData');

    final responseData = await Http.get(
        "https://today-api.moveforwardparty.org/api/main/content");

    return responseData;
  }

  static Future<Http.Response> getHashtagList() async {
    print('getHashtagList');
    var url = "https://today-api.moveforwardparty.org/api/hashtag/trend/";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
    };
    Map data = {
      "filter": {
        "limit": 4,
        "offset": 0,
        "relation": [],
        "whereConditions": {},
        "count": false,
        "orderBy": {}
      }
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    print('body$body');
    print('responseData${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> getProfileSS() async {
    var url = "https://today-api.moveforwardparty.org/api/page/search";

    Map data = {
      "limit": 10,
      "count": false,
      "isOfficial": true,
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(url, body: body);

    return responseData;
  }

  static Future<Http.Response> getPostList() async {
    final responseData = await Http.get(
        "https://today-api.moveforwardparty.org/api/main/content");
    return responseData;
  }

  static Future<Http.Response> getPostListSS(String idss) async {
    print('getPostListSS');

    // print('getData');

    final responseData = await Http.get(
        "https://today-api.moveforwardparty.org/api/page/$idss/post/?offset=0&limit=5");

    return responseData;
  }

  static List<PostListSS> parsePost(String responseBody) {
    var list = jsonDecode(responseBody) as List<dynamic>;
    List<PostListSS> postlist =
        list.map((model) => PostListSS.fromJson(model)).toList();
    return postlist;
  }

  static Future<List<PostListSS>> getPostListSS1(String idss,
      {int page = 1}) async {
    print('getPostListSS1');
    final headers = {
      "limit": 1,
      "count": false,
      "whereConditions": {"isHideStory": false}
    };
    // print('getData');

    final responseData = await Http.get(
        "https://today-api.moveforwardparty.org/api/page/$idss/post/?offset=$page&limit=5");
    if (responseData.statusCode == 200) {
      return compute(parsePost, responseData.body);
    } else if (responseData.statusCode == 404) {
      throw Exception('Not Found');
    }
  }

  static Future<Http.Response> getPostDetailSS(String id) async {
    print('getPostDetailSS');

    final responseData = await Http.get(
        "https://today-api.moveforwardparty.org/api/page/$id/post/?offset=0");

    return responseData;
  }

  static Future<List<SearchHastag>> getHt(String query) async {
    print('getHashtagList');
    var url = "https://today-api.moveforwardparty.org/api/hashtag/trend/";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
    };
    Map data = {
      "filter": {
        "limit": 4,
        "offset": 0,
        "relation": [],
        "whereConditions": {},
        "count": false,
        "orderBy": {}
      }
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    if (responseData.statusCode == 200) {
      final List ht = json.decode(responseData.body);

      return ht.map((json) => SearchHastag.fromJson(json)).where((book) {
        final titleLower = book.label.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<Http.Response> mantsearch(String quer) async {
    print('getHashtagList');
    var url = "https://today-api.moveforwardparty.org/api/main/search/";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
    };
    Map data = {
      "keyword": quer,
      "user": "6bf3212e-ae4b-4ca3-3702-41316afefa2e",
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    print('body$body');
    print('responseData${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> mantinitisearch() async {
    print('getHashtagList');
    var url = "https://today-api.moveforwardparty.org/api/hashtag/trend/";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
    };
    Map data = {
      // "keyword": "",
      // "user": "60c9cc216923656607919f06",
      "filter":{"limit":10,"offset":0,"relation":[],"whereConditions":{},"count":false,"orderBy":{}},"userId":"60c9cc216923656607919f06"
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    print('body$body');
    print('responseData${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> apisearchlist(String keyword,String hashtag) async {
    print('getHashtagList');
    var url = "https://today-api.moveforwardparty.org/api/main/content/search";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
    };
    Map data = {
      "keyword": [keyword],
      "hashtag": [hashtag],
      "type": "",
      "createBy": [],
      "objective": "",
      "pageCategories": [],
      "sortBy": "LASTEST_DATE",
      "filter": {"limit": 0, "offset": 0}
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    print('body$body');
    print('responseData${responseData.body}');

    return responseData;
  }
  static Future<Http.Response> getcommentlist(String postid,String uid) async {
    print('getcommentlist');
   
  
    var url = "https://today-api.moveforwardparty.org/api/post/$postid/comment/search";
    final headers = {
      "userid": uid,
            "content-type":"application/json"

      // "whereConditions": {"isHideStory": false},
    };
    Map data = {
      "limit": 0,
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    print('body$body');
    print('responseDatacommentlist${responseData.body}');

    return responseData;
  }

   static Future<Http.Response> sendcomment(String postid) async {
    print('sendcomment');
   
  
    var url = "https://today-api.moveforwardparty.org/api/post/$postid/comment";
    final headers = {
      "userid": "60c9cc216923656607919f06",
            "content-type":"application/json",
            "accept":"application/json"
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {
     "commentAsPage":"60c9cc216923656607919f06",
     "comment":"testsend"
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    print('body$body');
    print('responseDatacommentlist${responseData.body}');

    return responseData;
  }
}
