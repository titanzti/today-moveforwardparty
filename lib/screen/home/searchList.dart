import 'dart:convert';

import 'package:appmove/api/Api.dart';
import 'package:appmove/model/postModel.dart';
import 'package:appmove/model/searchpostlist.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchList extends StatefulWidget {
  final String label;
  final String type;


  const SearchList({Key key, this.label, this.type}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  List<SearchPostList> listSearchPostList = [];
  var loading = false;
  var dataht;
Future getsearchlist;
  @override
  void initState() {
    if(widget.type=="Null"){
getsearchlist=      Api.apisearchlist( widget.label,"").then((responseData) => ({
        setState(() {
          loading = true;
        }),
        print('getHashtagData'),
        if (responseData.statusCode == 200)
          {
            dataht = jsonDecode(responseData.body),
            for (Map i in dataht["data"])
              {
                print('testsc$i'),
                listSearchPostList.add(SearchPostList.fromJson(i)),
              },
               setState(() {
            loading = false;
        }),
          }
      }));
    }

  if(widget.type=="HASHTAG"){
    var  storytestreplaceAll = widget.label.replaceAll("#", "");
    print('storytestreplaceAll$storytestreplaceAll');
 getsearchlist=   Api.apisearchlist("",storytestreplaceAll).then((responseData) => ({
      setState(() {
        loading = true;
      }),
      print('getHashtagData'),
      if (responseData.statusCode == 200)
        {
          dataht = jsonDecode(responseData.body),
          for (Map i in dataht["data"])
            {
            
              print('testsc$i'),
              listSearchPostList.add(SearchPostList.fromJson(i)),
            },
 setState(() {
            loading = false;
        }),        }
    }));
  }
  if(widget.type=="TAG"){
    var  storytestreplaceAll = widget.label.replaceAll("#", "");
    print('storytestreplaceAll$storytestreplaceAll');
getsearchlist=    Api.apisearchlist("",storytestreplaceAll).then((responseData) => ({
      setState(() {
        loading = true;
      }),
      print('getHashtagData'),
      if (responseData.statusCode == 200)
        {
          dataht = jsonDecode(responseData.body),
          for (Map i in dataht["data"])
            {
              print('testsc$i'),
              listSearchPostList.add(SearchPostList.fromJson(i)),
            },
 setState(() {
            loading = false;
        }),        }
    }));
  }

  if(widget.type=="PAGE"){
    print('PAGE');
  getsearchlist=  Api.apisearchlist(widget.label,"").then((responseData) => ({
      setState(() {
        loading = true;
      }),
      print('getHashtagData'),
      if (responseData.statusCode == 200)
        {
          dataht = jsonDecode(responseData.body),
          for (Map i in dataht["data"])
            {
              print('testsc$i'),
              listSearchPostList.add(SearchPostList.fromJson(i)),
            },
 setState(() {
            loading = false;
        }),        }
    }));
  }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      color: Color(0xffF47932),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffF47932),
            title: Text('${widget.type}'),
          ),
          body: loading==true?Container(child: Text('loading...'),): SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             loading==true?   Text('${widget.label}'):Container(),
             FutureBuilder(
               future: Future.wait([
getsearchlist,
               ]),
              //  initialData: InitialData,
               builder: (BuildContext context, AsyncSnapshot snapshot) {
                 if(!snapshot.hasData) {
                         return Center(child: CupertinoActivityIndicator());
                       }
                 return ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listSearchPostList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(listSearchPostList.length==0) {
                         return Center(child: CupertinoActivityIndicator());
                       }
                    var nDataList1 = listSearchPostList[index];
                   

                    return  PostList(nDataList1);
                  },
                );
               },
             ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget PostList(nDataList1) {
    // var displayNamereplaceAll;
    // var displayname = nDataList1.owner.displayName.toString();
    // displayNamereplaceAll = displayname.replaceAll("DisplayName.", "");
    var base64String="https://today-api.moveforwardparty.org/api${nDataList1.post.coverImage.toString()}/image";

    return InkWell(
      child: Card(
        child: ListTile(
      title:  nDataList1.page.name == " "
          ? Text("Lable")
          : Text(nDataList1.page.name),
      subtitle: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          nDataList1.post.coverImage != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child:

              CachedNetworkImage(
                    imageUrl:
                        "https://today-api.moveforwardparty.org/api${nDataList1.post.coverImage.toString()}/image",
                    placeholder: (context, url) =>
                        new CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) =>
                        new Image.asset('images/placeholder.png'),
                  ),

                  // Image.network(
                  //   "https://today-api.moveforwardparty.org/api${nDataList1.post.coverImage}/image",
                  //   errorBuilder: (BuildContext context, Object exception,
                  //       StackTrace stacktrace) {
                  //     return Image.asset('images/placeholder.png');
                  //   },
                  //   headers: headers,
                  // ),
                )
              : const SizedBox.shrink(),
          nDataList1.post.title == null
              ? Text(
                  "Lable",
                  overflow: TextOverflow.clip,
                  style: TextStyle(color: Colors.black),
                  // maxLines: 2,
                )
              : Text(
                  "${nDataList1.post.title}",
                  overflow: TextOverflow.clip,
                  style: TextStyle(color: Colors.black),
                  // maxLines: 2,
                ),
          nDataList1.post.detail == null
              ? Text(
                  "Lable",
                  overflow: TextOverflow.clip,
                  // style: TextStyle(color: Colors.black),
                  // maxLines: 2,
                )
              : Text(
                  "${nDataList1.post.detail}",
                  overflow: TextOverflow.clip,
                  // style: TextStyle(color: Colors.black),
                  // maxLines: 2,
                ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(Icons.comment),
              Icon(Icons.repeat),
              Icon(Icons.favorite_border),
            ],
          )
        ],
      ),
      leading: CircleAvatar(
        radius: 20,
        child: Container(
          color: Colors.white,
          child: Image.network(
              "https://today-api.moveforwardparty.org/api${nDataList1.page.imageUrl}/image"),
        ),
      ),
      //
      // backgroundImage: NetworkImage(
      //     "https://today-api.moveforwardparty.org/api${nDataList1.owner.imageUrl}/image")),
      // trailing: Icon(icons[index])
    ),
    ),);
  }
}
