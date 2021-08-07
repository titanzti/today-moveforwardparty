import 'dart:convert';
import 'dart:developer';

import 'package:appmove/api/Api.dart';
import 'package:appmove/screen/info/infodeltil.dart';
import 'package:appmove/model/categorySSModel.dart';
import 'package:appmove/model/profilessModel.dart';
import 'package:appmove/screen/profile/Profiless.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:http/http.dart' as http;

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _InfoState extends State<Info> {
  var loading = false;
  var dataht;
  Future getDataProfile;
  List<ProfileSS> listProfileSSModel = [];
  List<ProfileSS> listProfileSSModel1 = [];
  List<ProfileSS> listProfileSSModel2 = [];
  List<ProfileSS> listProfileSSModel3 = [];
  List<ProfileSS> listProfileSSModel4 = [];
  List<ProfileSS> listProfileSSModel5 = [];
  List<ProfileSS> listProfileSSModel6 = [];
  List<ProfileSS> listProfileSSModel7 = [];
  List<ProfileSS> listProfileSSModel8 = [];
  List<ProfileSS> listProfileSSModel9 = [];
  List<ProfileSS> listProfileSSModel10 = [];
  List<ProfileSS> listProfileSSModel11 = [];
  List<ProfileSS> listProfileSSModel12 = [];
  List<ProfileSS> listProfileSSModel13 = [];
  List<ProfileSS> listProfileSSModel14 = [];
  List<ProfileSS> listProfileSSModel15 = [];

  // List<CategorySS> listCategorySSModel = [];
  String categoryid,
      categoryid1,
      categoryid2,
      categoryid3,
      categoryid4,
      categoryid5,
      categoryid6,
      categoryid7,
      categoryid8,
      categoryid9,
      categoryid10,
      categoryid11,
      categoryid12,
      categoryid13,
      categoryid14,
      categoryid15,
      categorySSname,
      categorySSname1,
      categorySSname2,
      categorySSname3,
      categorySSname4,
      categorySSname5,
      categorySSname6,
      categorySSname7,
      categorySSname8,
      categorySSname9,
      categorySSname10,
      categorySSname11,
      categorySSname12,
      categorySSname13,
      categorySSname14,
      categorySSname15;

  var mybody;

  Future getcategory() async {
    print('getProfileSS');
    try {
      var url =
          "https://today-api.moveforwardparty.org/api/page_category/search";
      final headers = {
        "content-type": "application/json",
      };
      Map data = {
        "limit": 0,
      };
      var body = jsonEncode(data);
      var responseRequest = await http.post(url, headers: headers, body: body);
      var name;
      if (responseRequest.statusCode == 200) {
        final jsonResponse = jsonDecode(responseRequest.body);
        setState(() {
          var date1 = jsonResponse["data"];
          categoryid = jsonResponse["data"][0]["id"];
          categoryid1 = jsonResponse["data"][1]["id"];
          categorySSname = jsonResponse["data"][0]["name"];
          categorySSname1 = jsonResponse["data"][1]["name"];
          categorySSname2 = jsonResponse["data"][2]["name"];
          categorySSname3 = jsonResponse["data"][3]["name"];
          categorySSname4 = jsonResponse["data"][4]["name"];
          categorySSname5 = jsonResponse["data"][5]["name"];
          categorySSname6 = jsonResponse["data"][6]["name"];
          categorySSname7 = jsonResponse["data"][7]["name"];
          categorySSname8 = jsonResponse["data"][8]["name"];
          categorySSname9 = jsonResponse["data"][9]["name"];
          categorySSname10 = jsonResponse["data"][10]["name"];
          categorySSname11 = jsonResponse["data"][11]["name"];
          categorySSname12 = jsonResponse["data"][12]["name"];
          categorySSname13 = jsonResponse["data"][13]["name"];
          categorySSname14 = jsonResponse["data"][14]["name"];
          categorySSname15 = jsonResponse["data"][15]["name"];
          print('categoryid$categoryid');
          print('categoryid1$categoryid1');
          print('categorySSname10$categorySSname10');
        });

        print("Response status :${jsonResponse.statusCode}");
        // print("Response status :${jsonResponse.body}");
      }
    } catch (e) {}
  }

  Future getProfileSS(String categoryid, String categoryid1) async {
    print('getProfileSS');
    try {
      var url = "https://today-api.moveforwardparty.org/api/page/search";
      final headers = {
        "content-type": "application/json",
      };
      Map data = {
        "limit": 0,
      };
      var body = jsonEncode(data);

      var responseRequest = await http.post(url, headers: headers, body: body);

      if (responseRequest.statusCode == 200) {
        final jsonResponse = jsonDecode(responseRequest.body);
        setState(() {
          print('datamap$jsonResponse["category"]');
          for (var i in jsonResponse["data"]) {
            String category = i["category"];
            print('ss$category');
            //=========================มูลนิธิ================
            if (category == "60213b2be4ba5937281976a4") {
              print('เข้ามูลนิธิ');
              listProfileSSModel.add(ProfileSS.fromJson(i));
              // print(listProfileSSModel.length);
            }
            if (category == "60213c1fe4ba5937281976a7") {
              print('เข้าหน่วยงานเอกชน');
              listProfileSSModel1.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
            if (category == "60220c347825c60ea6dc1636") {
              print('เข้าหน่วยงานเอกชน');
              listProfileSSModel2.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
            if (category == "6030af7d6aae4b0a2c5e9d05") {
              listProfileSSModel3.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
            if (category == "6030af866aae4b0a2c5e9d07") {
              listProfileSSModel4.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
            if (category == "6030b0436aae4b0a2c5e9d09") {
              listProfileSSModel5.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
            if (category == "6030b06e6aae4b0a2c5e9d0b") {
              listProfileSSModel6.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
            if (category == "6030b07c6aae4b0a2c5e9d0d") {
              listProfileSSModel7.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
            if (category == "60347e1fe1e737658b221284") {
              listProfileSSModel8.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
            if (category == "60d97dc0bee307079d19faf5") {
              listProfileSSModel9.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
            if (category == "60d97e13bee307079d19faf8") {
              listProfileSSModel10.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
            if (category == "60d97e95bee307079d19fb05") {
              listProfileSSModel11.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
            if (category == "60d97f1abee307079d19fb12") {
              listProfileSSModel12.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
            if (category == "60d97f61bee307079d19fb15") {
              listProfileSSModel13.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
            if (category == "60d97ff0d9b235079c055102") {
              listProfileSSModel14.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
            if (category == "60d9802dbee307079d19fb18") {
              listProfileSSModel15.add(ProfileSS.fromJson(i));
              print(listProfileSSModel1.length);
            }
          }
        });

        print("Response status :${jsonResponse.statusCode}");
        // print("Response status :${jsonResponse.body}");
      }

      // return responsepostRequest;
    } catch (e) {}
  }

  @override
  void initState() {
    getcategory();
    getDataProfile = getProfileSS(categoryid, categoryid1);

    // Api.getProfileSS().then((responseData) => ({
    //       // setState(() {
    //       //   loading = true;
    //       // }),
    //       print('getProfileSS'),
    //       if (responseData.statusCode == 200)
    //         {
    //           dataht = jsonDecode(responseData.body),
    //           for (Map i in dataht["data"])
    //             {
    //               listProfileSSModel.add(ProfileSS.fromJson(i)),
    //             },
    //           loading = false,
    //         }

    //     }));

    super.initState();
  }

  Widget _buildItemList(nDataList) {
    // if (index == title.length)
    //   return Center(
    //     child: CircularProgressIndicator(),
    //   );
    return InkWell(
      onTap: () {
        print(nDataList.id);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilessScreen(
                    id: nDataList.id,
                    image: nDataList.imageUrl,
                    name: nDataList.name,
                    lineId: nDataList.lineId,
                  )),
        );
      },
      child: Container(
        width: 160.0,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Wrap(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl:
                    "https://today-api.moveforwardparty.org/api${nDataList.imageUrl}/image",
                // imageUrl: "${nDataList[index]}",
                placeholder: (context, url) =>
                    new Center(child: new CupertinoActivityIndicator()),
                errorWidget: (context, url, error) =>
                    new Image.asset('images/placeholder.png'),
              ),
              ListTile(
                title: Center(
                    child: Text(nDataList.name,
                        style: TextStyle(fontWeight: FontWeight.bold))),
                // subtitle: Center(
                //     child: Text(subtitle[index],
                //         style: TextStyle(fontWeight: FontWeight.bold))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF47932),
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: Color(0xffF47932),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Color(0xffF47932),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("สมาชิก",
                            style: TextStyle(
                              color: Color(0xff0C3455),
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            )),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => InfoDeltil()),
                        //     );
                        //   },
                        //   child: Container(
                        //     child: Text('ดูเพิ่มเติม',
                        //         style: TextStyle(
                        //           color: Color(0xff0C3455),
                        //           fontSize: 14.0,
                        //           fontWeight: FontWeight.bold,
                        //           letterSpacing: 1.0,
                        //         )),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname1 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname1',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel1.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel1[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname2 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname2',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel2.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel2[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname3 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname3',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel3.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel3[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname4 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname4',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel4.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel4[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname5 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname5',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel5.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel5[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname6 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname6',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel6.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel6[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname7 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname7',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel7.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel7[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname8 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname8',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel8.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel8[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname9 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname9',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel9.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel9[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname10 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname10',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel10.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel10[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname11 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname11',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel11.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel11[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname12 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname12',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel12.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel12[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname13 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname13',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel13.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel13[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname14 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname14',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel14.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel14[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(2),

                  // width: double.infinity,
                  child: categorySSname15 == null
                      ? Text('Lable',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ))
                      : Text('$categorySSname15',
                          style: TextStyle(
                            color: Color(0xff0C3455),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )),
                ),
                FutureBuilder(
                  future: Future.wait([
                    getDataProfile,
                  ]),
                  builder:
                      ((BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    print('snapshot${snapshot.data}');
                    if (!snapshot.hasData) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listProfileSSModel15.length,
                        padding: EdgeInsets.all(2),
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel15[index];
                          // print(nDataList.id);

                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
