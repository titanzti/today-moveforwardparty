import 'dart:io';

import 'package:appmove/utils/testref1.dart';
import 'package:flutter/material.dart';
import 'package:appmove/utils/testref.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
class Modelshop extends StatefulWidget {
  @override
  _ModelshopState createState() => _ModelshopState();
}

class _ModelshopState extends State<Modelshop> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Container listshop(String listshop) {
    return Container(
      child: RaisedButton(
          color: Colors.white,
          child: Text(
            listshop,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          onPressed: () {},
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Color(0xffF47932),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0xffF47932),
          body: SingleChildScrollView(
            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'รายการสินค้า',
                    style: TextStyle(
                      color: Color(0xff0C3455),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
                // Container(
                //   padding: EdgeInsets.only(left: 10),
                //   child: Wrap(
                //     direction: Axis.horizontal,
                //     spacing: 20.0,
                //     runSpacing: 10.0,
                //     children: <Widget>[
                //       listshop("สินค้าใหม่"),
                //       listshop("เสื้อ"),
                //       listshop("หมวก"),
                //     ],
                //   ),
                // ),
                SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.all(10),
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 17),
                            blurRadius: 23,
                            spreadRadius: -13,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 80,
                            width: 60,
                            child: Image.asset(
                              'images/polo.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "เสื้อPolo",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  "รายละเอียดเพิ่มเติม",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Text(
                                  '250 บาท',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: InkWell(
                                onTap: () async{
                               HapticFeedback.lightImpact();
                               _scaffoldKey.currentState.showSnackBar(SnackBar(
                               content: Text('ไม่มีidlineจ้า'),
                                   ));
                          print('กด');
                          if (Platform.isAndroid) {
                            String uri =
                                'line://oaMessage/@${'widget.lineId'}/123';
                            if (await canLaunch(uri)) {
                              await launch(uri);
                            } else {
                              throw 'Could not launch $uri';
                            }
                          } else if (Platform.isIOS) {
                            // iOS
                            String uri =
                                'line://oaMessage/@${'widget.lineId'}/123';
                            if (await canLaunch(uri)) {
                              await launch(uri);
                            } else {
                              throw 'Could not launch $uri';
                            }
                          }
                                },
                               child:  Image.asset(
                                'images/logoline.png',
                                fit: BoxFit.cover,
                              ),
                              ),
                            ), // child: SvgPicture.asset("assets/icons/Lock.svg"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.all(10),
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 17),
                            blurRadius: 23,
                            spreadRadius: -13,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 80,
                            width: 60,
                            child: Image.asset(
                              'images/hat.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "หมวก",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  "รายละเอียดเพิ่มเติม",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Text(
                                  '450 บาท',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                'images/logoline.png',
                                fit: BoxFit.cover,
                              ),
                            ), // child: SvgPicture.asset("assets/icons/Lock.svg"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.all(10),
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 17),
                            blurRadius: 23,
                            spreadRadius: -13,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 80,
                            width: 60,
                            child: Image.asset(
                              'images/bag.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                                                    SizedBox(width: 20),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "กระเป๋าผ้าก้าวไกล",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  "รายละเอียดเพิ่มเติม",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Text(
                                  '450 บาท',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                         Padding(
                            padding: EdgeInsets.all(10),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                'images/logoline.png',
                                fit: BoxFit.cover,
                              ),
                            ), // child: SvgPicture.asset("assets/icons/Lock.svg"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
