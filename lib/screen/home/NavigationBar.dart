import 'package:appmove/api/Api.dart';
import 'package:appmove/screen/info/info.dart';
import 'package:appmove/screen/home/HomeScreen.dart';
import 'package:appmove/screen/loginandregister/Intro.dart';
import 'package:appmove/screen/modle/Modelshop.dart';
import 'package:appmove/screen/profile/Profile.dart';
import 'package:appmove/screen/support/Support.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class Appbar extends StatefulWidget {
  // final bool islogin;

  const Appbar({Key key}) : super(key: key);
  @override
  _AppbarState createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  int currentTab = 0; // to keep track of active tab index
  bool islogins;
  // final List<Widget> screens = [
  //   HomeScreen(),
  //   Profiless(),
  //   Modelshop(),
  //   Intro(),
  //   Support(),
  // ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  // _logout() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     preferences.remove("token");
  //     preferences.clear();

  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
  //         (Route<dynamic> route) => false);
  //   });
  // }

  AnimationController controller;

  bool isloginn = false;
  bool isClick = true;
  bool _enabled = false;

  var checktoken;

  var myuid;

  @override
  void initState() {
    super.initState();
    setState(() {
      Api.gettoke().then((value) => value({
            checktoken = value,
            print('checktokenAppbar$checktoken'),
          }));

      Api.getmyuid().then((value) => ({
            setState(() {
              myuid = value;
            }),
            print('myuidAppbar$myuid'),
          }));
    });
    // _nameRetriever();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: Container(
        width: currentTab == 0 ? 70 : 60,
        height: currentTab == 0 ? 70 : 60,
        child: FloatingActionButton(
          backgroundColor: currentTab == 0 ? Color(0xffF47932) : Colors.grey,
          child: currentTab == 0
              ? Image.asset(
                  "images/MFP-Logo-Vertifcle-White.png",
                  height: 200,
                  width: 200,
                  // fit: (BoxFit.fill),
                )
              : Image.asset(
                  "images/MFP-Logo-Vertifcle-White.png",
                  height: 80,
                  width: 80,
                  // fit: (BoxFit.fill),
                ),
          onPressed: () {
            setState(() {
              HapticFeedback.lightImpact();

              isClick = false;
              _enabled = !_enabled;
              currentScreen = HomeScreen();
              currentTab = 0;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 2,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        HapticFeedback.lightImpact();

                        currentScreen = Info();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.supervisor_account_outlined,
                          color:
                              currentTab == 1 ? Color(0xffF47932) : Colors.grey,
                        ),
                        Text(
                          'สมาชิก',
                          style: TextStyle(
                            color: currentTab == 1
                                ? Color(0xffF47932)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        HapticFeedback.lightImpact();

                        currentScreen = Support();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.card_giftcard,
                          color:
                              currentTab == 2 ? Color(0xffF47932) : Colors.grey,
                        ),
                        Text(
                          'บริจาค',
                          style: TextStyle(
                            color: currentTab == 2
                                ? Color(0xffF47932)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        HapticFeedback.lightImpact();

                        currentScreen = Modelshop();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.shop_outlined,
                          color:
                              currentTab == 3 ? Color(0xffF47932) : Colors.grey,
                        ),
                        Text(
                          'ร้านค้า',
                          style: TextStyle(
                            color: currentTab == 3
                                ? Color(0xffF47932)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        // currentScreen = Profile();
                        HapticFeedback.lightImpact();

                        currentScreen = Profile(
                          istoken: checktoken,
                          myuid: myuid,
                        );
                        if (checktoken == null || checktoken == "") {
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => Intro(),
                          );
                        }

                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color:
                              currentTab == 4 ? Color(0xffF47932) : Colors.grey,
                        ),
                        Text(
                          'โปรไฟล์',
                          style: TextStyle(
                            color: currentTab == 4
                                ? Color(0xffF47932)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
