import 'dart:convert';

import 'package:appmove/api/Api.dart';
import 'package:appmove/model/pagemodel.dart';
import 'package:appmove/model/searchhastag.dart';
import 'package:appmove/screen/home/searchList.dart';
import 'package:appmove/utils/internetConnectivity.dart';
import 'package:appmove/widgets/allWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appmove/screen/profile/Profiless.dart';

class Searchbar extends StatefulWidget {
  @override
  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  TextEditingController controller = new TextEditingController();
  List<SearchHastag> listSearchHastag = [];
  List<PageModel> _listPageModel = [];
  List<PageModel> _listPageModelResult = [];

  List<SearchHastag> _searchResult = [];

  List<SearchHastag> _searchinitiResult = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var loading = false;
  var dataht;
  Future getHashtagList;
  ScrollController scrollController;
  List _allResults = [];
  List _resultsList = [];
  List distinctIds = [];
  var keyword, isType, isvalue;

  var myuid;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  getdate(String quer) async {
    // Future.delayed(Duration(seconds: 2));
    var url = "https://today-api.moveforwardparty.org/api/main/search";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
    };
    Map data = {
      "keyword": quer,
      "user": "60c9cc216923656607919f06",
    };
    var body = jsonEncode(data);

    final responseData = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print('body$body');
    print('responseData${responseData.body}');
    setState(() {
      loading = true;
    });
    print('getHashtagList');
    if (responseData.statusCode == 200) {
      dataht = jsonDecode(responseData.body);
      print('data${dataht["data"]}');
      for (Map i in dataht["data"]["result"]) {
        // Future.delayed(Duration(seconds: 30));

        print('isUser$isType');

        listSearchHastag.add(SearchHastag.fromJson(i));

        // if (listSearchHastag.indexOf(SearchHastag.fromJson(i)) <= -1) {
        // }
        // if (listSearchHastag.indexOf(SearchHastag.fromJson(i)) <= 0) {
        //   listSearchHastag.remove(listSearchHastag);
        // }

        print('listSearchHastagจำนวน${listSearchHastag.length}');
        print('_searchResult${_searchResult.length}');

        if (controller.text.isEmpty) {
          print("controllerวางจริง");
          listSearchHastag.clear();
        }
      }

      loading = false;
    }
  }

  getpage(String pageid) async {
    print('getPageisvalue$pageid');
    final headers = {
      // "limit": 1,
      // "count": false,
      // "whereConditions": {"isHideStory": false},
      "content-type": "application/json"
    };
    // print('getData');

    final responseData = await http.get(
        "https://today-api.moveforwardparty.org/api/page/$pageid",
        headers: headers);
    if (responseData.statusCode == 200) {
      setState(() {
        loading = true;
      });
      if (responseData.statusCode == 200) {
        var dataht1 = jsonDecode(responseData.body);
        print('listPageModel${dataht1["data"]}');
        if (isType == "PAGE") {
          _listPageModel.add(PageModel.fromJson(dataht1["data"]));
          print('listPageModellength${_listPageModel.length}');
        }

        loading = false;
        print('body$dataht1');
        print('responseDatagetpage${responseData.body}');
      }
    } else if (responseData.statusCode == 404) {
      throw Exception('Not Found');
    }
  }

  @override
  void didChangeDependencies() {
    getdate(controller.text.toLowerCase());
    getpage(isvalue);

    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void initState() {
    checkInternetConnectivity().then((value) => {
          value == true
              ? () {
                  setState(() {
                    scrollController = ScrollController();
                    // getdate(controller.text.toLowerCase());

                    // Api.mantsearch("ท");

                    // getHashtagList =
                      Api.getmyuid().then((value) => ({
                          setState(() {
                            myuid = value;
                          }),
                          print('myuidhome$myuid'),
                        }));
                    Api.mantinitisearch(myuid).then((responseData) => ({
                          setState(() {
                            loading = true;
                          }),
                          print('getHashtagList'),
                          if (responseData.statusCode == 200)
                            {
                              dataht = jsonDecode(responseData.body),
                              print('data${dataht["data"]}'),
                              for (Map i in dataht["data"])
                                {
                                  // print("type${i["type"]}"),
                                  _searchinitiResult
                                      .add(SearchHastag.fromJson(i)),
                                  print('จำนวน${listSearchHastag.length}'),
                                },
                              loading = false,
                            }
                        }));
                    // getHashtagList=    Api.getpage(isUser).then((responseData) => ({
                    //   setState(() {
                    //     loading = true;
                    //   }),
                    //   print('getHashtagList'),
                    //   if (responseData.statusCode == 200)
                    //     {
                    //       dataht = jsonDecode(responseData.body),
                    //       print('data${dataht["data"]}'),
                    //       for (Map i in dataht["data"])
                    //         {
                    //           // print("type${i["type"]}"),
                    //           listPageModel
                    //               .add(PageModel.fromJson(i)),
                    //           print('จำนวน${listSearchHastag.length}'),
                    //         },
                    //       loading = false,
                    //     }
                    // }));
                    // Api.getHashtagList().then((responseData) => ({
                    //       setState(() {
                    //         loading = true;
                    //       }),
                    //       print('getHashtagList'),
                    //       if (responseData.statusCode == 200)
                    //         {
                    //           dataht = jsonDecode(responseData.body),
                    //           print('data${dataht["data"]}'),
                    //           for (Map i in dataht["data"])
                    //             {
                    //               _searchResult.add(SearchHastag.fromJson(i)),
                    //             },
                    //           loading = false,
                    //         }
                    //     }));

                    // getData();
                    // getDatasectionModels();
                  });
                }()
              : showNoInternetSnack(_scaffoldKey)
        });
    super.initState();
    controller.addListener(_onSearchChanged);

    // getUserDetails();
  }

  _onSearchChanged() {
    // searchResultsList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor: Color(0xffF47932),
        title: new Text(
          'ค้นหา',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        // scrollDirection: Axis.vertical,
        child: Column(
          children: [
            new Container(
              color: Color(0xffF47932),
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  child: new ListTile(
                    leading: new Icon(Icons.search),
                    title: new TextField(
                      // autofocus: true,
                      controller: controller,
                      decoration: new InputDecoration(
                          hintText: 'Search...', border: InputBorder.none),
                      onChanged: (text) {
                        text = text.toLowerCase();
                        if (controller.text != "") {
                          setState(() {
                            _searchResult = listSearchHastag.where((ht) {
                              // distinctIds = _searchResult.toSet().toList();
                              // print('distinctIds${distinctIds.length}');
                              var htlable = ht.label.toLowerCase();
                              return htlable
                                  .contains(controller.text.toLowerCase());
                            }).toList();
                          });
                          setState(() {
                            listSearchHastag.clear();
                          });

                          getdate(controller.text.toLowerCase());
                          setState(() {
                            _listPageModel.clear();
                          });

                          getpage(isvalue);
                        }
                        if (controller.text.isEmpty) {
                          print("controllerวางจริง");
                          setState(() {
                            controller.clear();
                            listSearchHastag.clear();
                            _searchResult.clear();
                          });
                        }

                        if (controller.text.isEmpty) {
                          print("onChangedวางจริง");
                          setState(() {
                            controller.clear();
                            listSearchHastag.clear();
                            _searchResult.clear();
                          });
                        }
                      },
                      onSubmitted: (text) {
                        keyword = text;
                        print("กดSubmitted");
                        text = text.toLowerCase();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchList(
                                    type: "Null",
                                    label: keyword,
                                  )),
                        );
                        // if (controller.text != "") {
                        //   setState(() {
                        //     _searchResult = listSearchHastag.where((ht) {
                        //       // distinctIds = _searchResult.toSet().toList();
                        //       // print('distinctIds${distinctIds.length}');
                        //       var htlable = ht.label.toLowerCase();
                        //       return htlable
                        //           .contains(controller.text.toLowerCase());
                        //     }).toList();
                        //   });
                        //   getdate(controller.text.toLowerCase());
                        // }
                        // if (controller.text.isEmpty) {
                        //   print("controllerวางจริง");
                        //   setState(() {
                        //     controller.clear();
                        //     listSearchHastag.clear();
                        //     _searchResult.clear();
                        //   });
                        // }
                      },
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          controller.clear();
                          listSearchHastag.clear();
                          _searchResult.clear();
                          _listPageModel.clear();
                        });

                        // onSearchTextChanged('');
                      },
                    ),
                  ),
                ),
              ),
            ),
            controller.text == ""
                ? new Align(
                    alignment: Alignment.bottomLeft,
                    child: new Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Text(
                        "เทรนสำหรับคุณ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Container(),
            controller.text == ""
                ? Builder(builder: (BuildContext context) {
                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        if (_searchinitiResult.length == 0) {
                          return CupertinoActivityIndicator();
                        }
                        var data = _searchinitiResult[index];
                        var istype = data.type;
                        var islabel = data.label;
                        return new InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchList(
                                        type: istype,
                                        label: islabel,
                                      )),
                            );
                          },
                          child: Column(
                            children: [
                              ListTile(
                                // leading: new CircleAvatar(
                                //   backgroundImage: new NetworkImage(
                                //     _userDetails[index].profileUrl,
                                //   ),
                                // ),
                                title: new Text(data.label),
                                // subtitle: new Text(data.type.toString()),
                              ),
                              Divider(
                                height: 2,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  })
                : Container(),
            listSearchHastag.length != 0 || controller.text != ""
                ? new Builder(builder: (BuildContext context) {
                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listSearchHastag.length,
                      itemBuilder: (context, i) {
                        var data = listSearchHastag[i];
                        var istype = data.type;
                        var islabel = data.label;
                        isType = data.type;
                        if (isType == "PAGE") {
                          isvalue = data.value;
                        }
                        print('isty$isType');
                        print("isva$isvalue");
                        return new InkWell(
                          onTap: () {
                            if (istype == "HASHTAG") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchList(
                                          type: istype,
                                          label: islabel,
                                        )),
                              );
                            }
                            if (istype == "PAGE") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchList(
                                          type: istype,
                                          label: islabel,
                                        )),
                              );
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.all(
                              Radius.circular(15.0),
                            )),
                            child: new ListTile(
                              // leading: new CircleAvatar(
                              //   backgroundImage: new NetworkImage(
                              //     _userDetails[index].profileUrl,
                              //   ),
                              // ),
                              title: new Text('${data.label}'),
                              // subtitle: new Text('>>>${data.type}'),
                            ),
                            margin: const EdgeInsets.all(2.0),
                          ),
                        );
                      },
                    );
                  })
                : Container(),
            listSearchHastag.length != 0 || controller.text != ""
                ? ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _listPageModel.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = _listPageModel[index];
                      return new InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilessScreen(
                                      id: data.id,
                                      image: data.imageUrl,
                                      name: data.name,
                                    )),
                          );
                        },
                        child: Card(
                          child: new ListTile(
                            leading: new CircleAvatar(
                              child: Container(
                                color: Colors.white,
                                child: Image.network(
                                    "https://today-api.moveforwardparty.org/api${data.imageUrl}/image"),
                              ),
                            ),
                            title: new Text('${data.name}'),
                            subtitle:
                                new Text('@${data.pageUsername}'),
                          ),
                          margin: const EdgeInsets.all(0.0),
                        ),
                      );
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  // onSearchTextChanged(String text) async {
  //   _searchResult.clear();
  //   if (text.isEmpty) {
  //     setState(() {});
  //     return;
  //   }

  //   _userDetails.forEach((userDetail) {
  //     if (userDetail.firstName.contains(text) ||
  //         userDetail.lastName.contains(text)) _searchResult.add(userDetail);
  //   });

  //   setState(() {});
  // }
}

// List<UserDetails> _userDetails = [];

// final String url = 'https://jsonplaceholder.typicode.com/users';

// class UserDetails {
//   final int id;
//   final String firstName, lastName, profileUrl;

//   UserDetails(
//       {this.id,
//       this.firstName,
//       this.lastName,
//       this.profileUrl =
//           'https://i.amz.mshcdn.com/3NbrfEiECotKyhcUhgPJHbrL7zM=/950x534/filters:quality(90)/2014%2F06%2F02%2Fc0%2Fzuckheadsho.a33d0.jpg'});

//   factory UserDetails.fromJson(Map<String, dynamic> json) {
//     return new UserDetails(
//       id: json['id'],
//       firstName: json['name'],
//       lastName: json['username'],
//     );
//   }
// }
