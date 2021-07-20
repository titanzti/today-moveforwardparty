import 'dart:convert';

import 'package:appmove/api/Api.dart';
import 'package:appmove/infodeltil.dart';
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

List<String> images = [
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_3662-e1598935420456.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_4735-e1598859153679.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/11/1605767996948.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_3651-e1598862075362.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_4609-e1598867560547.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4364-e1598939298188.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4138-e1598942042209.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_4111-e1598856036966.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_3961-e1598941945762.jpg",
];

List<String> title = [
  "พิธาลิ้ม เจริญรัตน์",
  "ชัยธวัช ตุลาธน",
  "ณกรณ์พงศ์ ศุภนิมิตตระกูล",
  "ณธีภัสร์ กุลเศรษฐสิทธิ์",
  "สมชาย ฝั่งชลจิตร",
  "อมรัตน์ โชคปมิตต์กุล",
  "เบญจา แสงจันทร์",
  "อภิชาต ศิริสุนทร",
];
List<String> subtitle = [
  "หัวหน้าพรรคก้าวไกล",
  "เลขาธิการพรรคก้าวไกล",
  "นายทะเบียนสมาชิกพรรค",
  "เหรัญญิกพรรคก้าวไกล",
  "กรรมการบริหารสัดส่วนภาคใต้",
  "กรรมการบริหารสัดส่วนภาคกลาง",
  "กรรมการบริหารสัดส่วนภาคตะวันออก",
  "กรรมการบริหารสัดส่วนภาคเหนือ",
];
List<String> images1 = [
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4678-e1598942607679.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_36961-e1598863543129.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_3697-e1598855869626.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4654-e1598939009945.jpg",
];
List<String> title1 = [
  "พิจารณ์ เชาวพัฒนวงศ์",
  "ณัฐวุฒิ บัวประทุม",
  "สุพิศาล ภักดีนฤนาถ",
  "ศิริกัญญา ตันสกุล",
];
List<String> subtitle1 = [
  "รองหัวหน้าพรรคฝ่ายกิจการสภา",
  "รองหัวหน้าพรรคฝ่ายกฎหมาย",
  "รองหัวหน้าพรรคฝ่ายการเมืองและกิจการพิเศษ",
  "รองหัวหน้าพรรคฝ่ายนโยบาย",
];
List<String> images2 = [
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4227-e1598938277746.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_4054-e1598862250142.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_3911-e1598939983891.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_3667-e1598852695729.jpg",
];
List<String> title2 = [
  "วิโรจน์ ลักขณาอดิศร",
  "ณัฐชา บุญไชยอินสวัสดิ์",
  "สุทธวรรณ สุบรรณ ณ อยุธยา",
  "ธัญญ์วาริน สุขะพิสิษฐ์",
];
List<String> subtitle2 = [
  "โฆษกพรรค",
  "โฆษกพรรค",
  "โฆษกพรรค",
  "โฆษกพรรค",
];
List<String> images3 = [
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_3662-e1598935420456.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_3882-e1598937553211.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_3764-e1598940078290.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4678-e1598942607679.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_3961-e1598941945762.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4654-e1598939009945.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_3814-e1598935701820.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4533-e1598937813633.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4159-e1598940436540.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4494-e1598935090807.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_4195-e1598855929354.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_3722-e1598852830929.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_45901-e1598856583671.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4364-e1598939298188.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/11/Wayo-A..jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_4265-e1598855822484.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4138-e1598942042209.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_3697-e1598855869626.jpg",
  "(https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_3939-e1598866440838.jpg",
  "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4227-e1598938277746.jpg",
];
List<String> title3 = [
  "พิธา ลิ้มเจริญรัตน์",
  "วรรณวิภา ไม้สน",
  "สุรเชษฐ์ ประวีณวงศ์วุฒิ",
  "พิจารณ์ เชาวพัฒนวงศ์",
  "อภิชาต ศิริสุนทร",
  "ศิริกัญญา ตันสกุล",
  "รังสิมันต์ โรม",
  "วินท์ สุธีรชัย",
  "สุเทพ อู่อ้น",
  "ปริญญา ช่วยเกตุ คีรีรัตน์",
  "ณัฐพล สืบศักดิ์วงศ์",
  "ธัญวัจน์ กมลวงศ์วัฒน์",
  "คารม พลพรกลาง",
  "สมชาย ฝั่งชลจิตร",
  "วาโย อัศวรุ่งเรือง",
  "คําพอง เทพาคํา",
  "อมรัตน์ โชคปมิตต์กุล",
  "สุพิศาล ภักดีนฤนาถ",
  "นิติพล ผิวเหมาะ",
  "วิโรจน์ ลักขณาอดิศร",
];
var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _InfoState extends State<Info> {
  var loading = false;
  var dataht;
  Future getDataProfile;
  List<ProfileSS> listProfileSSModel = [];
  List<CategorySS> listCategorySSModel = [];
  String categoryid, categorySSname;

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
        "limit": 10,
        "count": false,
        // "whereConditions": {"isOfficial": true}
      };
      var body = jsonEncode(data);

      var responseRequest = await http.post(url, headers: headers, body: body);

      // print("${responseRequest.statusCode}");
      print("${responseRequest.body}");

      if (responseRequest.statusCode == 200) {
        final jsonResponse = jsonDecode(responseRequest.body);
        // print(jsonResponse["data"][id]);
        setState(() {
          var date1 = jsonResponse["data"];
          categorySSname = jsonResponse["data"][6]["name"];
          print('categoryid$categoryid');

          print('categoryname$categorySSname');

          for (Map i in date1) {
            categoryid = i[6]["id"];

            // listCategorySSModel.add(CategorySS.fromJson(i));
            print(listCategorySSModel.length);
            // print(i);
          }
        });

        print("Response status :${jsonResponse.statusCode}");
        // print("Response status :${jsonResponse.body}");
      }

      // return responsepostRequest;
    } catch (e) {}
  }

  Future getProfileSS(String categoryid) async {
    print('getProfileSS');
    try {
      var url = "https://today-api.moveforwardparty.org/api/page/search";
      final headers = {
        "content-type": "application/json",
      };
      Map data = {
        "limit": 10,
        "count": false,
        // "category": "60213b2be4ba5937281976a4"
        "whereConditions": {"isOfficial": true}
      };
      var body = jsonEncode(data);

      var responseRequest = await http.post(url, headers: headers, body: body);

      // print("${responseRequest.statusCode}");
      // print("${responsepostRequest.body}");

      if (responseRequest.statusCode == 200) {
        final jsonResponse = jsonDecode(responseRequest.body);
        // print(jsonResponse["data"][id]);
        setState(() {
          var date1 = jsonResponse["data"];
          // print('datamap$jsonResponse["category"]');
          for (var i in date1) {
            String category = i["category"];
            print('ss$category');

            if (category == "6030b06e6aae4b0a2c5e9d0b") {
              listProfileSSModel.add(ProfileSS.fromJson(i));

              print(listProfileSSModel.length);
            }
            // listProfileSSModel.add(ProfileSS.fromJson(i));

            // print(i);
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
    getDataProfile = getProfileSS(categoryid);

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

  Widget _buildItemList1(BuildContext context, int index) {
    if (index == title1.length)
      return Center(
        child: CupertinoActivityIndicator(),
      );
    return Container(
      width: 160.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Wrap(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: "${images1[index]}",
              placeholder: (context, url) =>
                  new Center(child: new CupertinoActivityIndicator()),
              errorWidget: (context, url, error) =>
                  new Image.asset('images/placeholder.png'),
            ),
            ListTile(
              title: Center(
                  child: Text(title1[index],
                      style: TextStyle(fontWeight: FontWeight.bold))),
              subtitle: Center(
                  child: Text(subtitle1[index],
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemList2(BuildContext context, int index) {
    if (index == title2.length)
      return Center(
        child: CupertinoActivityIndicator(),
      );
    return Container(
      width: 160.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Wrap(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: "${images2[index]}",
              placeholder: (context, url) =>
                  new Center(child: new CupertinoActivityIndicator()),
              errorWidget: (context, url, error) =>
                  new Image.asset('images/placeholder.png'),
            ),
            ListTile(
              title: Center(
                  child: Text(title2[index],
                      style: TextStyle(fontWeight: FontWeight.bold))),
              subtitle: Center(
                  child: Text(subtitle2[index],
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemList3(BuildContext context, int index) {
    if (index == title3.length)
      return Center(
        child: CupertinoActivityIndicator(),
      );
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InfoDeltil(
                    title: title3[index],
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
              Image.network(images3[index], fit: BoxFit.cover),
              ListTile(
                title: Center(
                    child: Text(title3[index],
                        style: TextStyle(fontWeight: FontWeight.bold))),
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
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoDeltil()),
                            );
                          },
                          child: Container(
                            // width: 60,
                            // height: 25,
                            // decoration: BoxDecoration(
                            //   color: Colors.white.withOpacity(0.5),
                            //   borderRadius:
                            //       BorderRadius.all(Radius.circular(8)),
                            // ),
                            // width: double.infinity,

                            child: Text('ดูเพิ่มเติม',
                                style: TextStyle(
                                  color: Color(0xff0C3455),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  // width: double.infinity,
                  color: Colors.white,
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
                        itemBuilder: ((
                          BuildContext context,
                          int index,
                        ) {
                          final nDataList = listProfileSSModel[index];
                          // print(nDataList.id);
                          print('nDataList$nDataList');
                          return _buildItemList(nDataList);
                        }),
                      ),
                    );
                  }),
                ),

//  SizedBox(
//                   height: 30,
//                 ),
                Container(
                  color: Colors.white,
                  child: Text('รองหัวหน้าพรรคก้าวไกล',
                      style: TextStyle(
                        color: Color(0xff0C3455),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      )),
                ),
                Container(
                  // margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 250,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: _buildItemList1,
                    itemCount: title1.length,
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Text('คณะโฆษกพรรคก้าวไกล',
                      style: TextStyle(
                        color: Color(0xff0C3455),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      )),
                ),

                Container(
                  // margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 250,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: _buildItemList2,
                    itemCount: title2.length,
                  ),
                ),

                // SizedBox(
                //   width: 400,
                //   height: 200,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(20)),
                //     ),
                //     // color: Colors.white,
                //     // // width: 400,
                //     // // height: 400,
                //     child: Expanded(
                //       child: ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         itemBuilder: _buildItemList2,
                //         itemCount: title2.length,
                //       ),
                //     ),
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Container(
                //       // width: double.infinity,
                //       color: Colors.white,
                //       child: Text(
                //           'สมาชิกสภาผู้แทนราษฎร\nพรรคก้าวไกลแบบบัญชีรายชื่อ',
                //           style: TextStyle(
                //             color: Color(0xff0C3455),
                //             fontSize: 18.0,
                //             fontWeight: FontWeight.bold,
                //             letterSpacing: 1.0,
                //           )),
                //     ),
                //     InkWell(
                //       onTap: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) => InfoDeltil()),
                //         );
                //       },
                //       child: Container(
                //         // width: double.infinity,
                //         color: Colors.white,
                //         child: Text('ดูเพิ่มเติม',
                //             style: TextStyle(
                //               color: Color(0xff0C3455),
                //               fontSize: 14.0,
                //               fontWeight: FontWeight.bold,
                //               letterSpacing: 1.0,
                //             )),
                //       ),
                //     ),
                //   ],
                // ),
                // Container(
                //   color: Color(0xffF47932),
                //   child: SizedBox(
                //     width: 400,
                //     height: 200,
                //     child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(20)),
                //       ),
                //       child: Expanded(
                //         child: ListView.builder(
                //           scrollDirection: Axis.horizontal,
                //           itemBuilder: _buildItemList3,
                //           itemCount: 3,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          //),
        ),
      ),
    );
  }
}
