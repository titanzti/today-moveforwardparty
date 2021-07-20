// import 'dart:convert';
// import 'package:appmove/model/searchhastag.dart';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';

// class Search extends StatefulWidget {
//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   var loading = false;
//   var dataht;
//   List<SearchHastag> listSearchHastag = [];

//   getdate(String quer) async {
//     var url = "https://today-api.moveforwardparty.org/api/main/search/";
//     final headers = {
//       // "mode": "EMAIL",
//       "content-type": "application/json",
//     };
//     Map data = {
//       "keyword": quer,
//       "user": "6bf3212e-ae4b-4ca3-3702-41316afefa2e",
//     };
//     var body = jsonEncode(data);

//     final responseData = await http.post(
//       url,
//       headers: headers,
//       body: body,
//     );
//     print('body$body');
//     print('responseData${responseData.body}');

//     print('getHashtagList');
//     if (responseData.statusCode == 200) {
//       dataht = jsonDecode(responseData.body);
//       print('data${dataht["data"]}');
//       for (Map i in dataht["data"]["result"]) {
//         listSearchHastag.add(SearchHastag.fromJson(i));
//         print('จำนวน${listSearchHastag.length}');
//       }
//     }
//   }

//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Color(0xffF47932),
//           title: Text('ค้นหา'),
//           centerTitle: true,
//           actions: <Widget>[
//             IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: () {
//                   showSearch(context: context, delegate: DataSearch());
//                 })
//           ]),
//       body: Container(
//         child: Text('data'),
//       ),
//     );
//   }
// }

// class DataSearch extends SearchDelegate<String> {
//   final testdata = [
//     "#data1",
//     "#data2",
//     "#data3",
//     "#data4",
//     "#data5",
//     "#data6",
//     "name1",
//     "name2",
//     "name3",
//     "name4",
//     "name5",
//     "name6",
//     "posts1",
//     "posts2",
//     "posts3",
//     "posts4",
//     "posts5",
//     "posts6"
//   ];

//   final recentTestdata = [
//     "#data",
//     "name",
//     "posts",
//   ];
  
//   List<SearchHastag> listSearchHastag = [];

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//           icon: Icon(Icons.clear),
//           onPressed: () {
//             print("กด");
//             query = "";
//           })
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//         icon: AnimatedIcon(
//           icon: AnimatedIcons.menu_arrow,
//           progress: transitionAnimation,
//         ),
//         onPressed: () {
//           close(context, null);
//         });
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return null;
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestionList = query.isEmpty
//         ? recentTestdata
//         : testdata.where((k) => k.startsWith(query)).toList();
//     print(query);

//     return ListView.builder(
//       itemBuilder: (context, index) => ListTile(
//         onTap: () {
//           showResults(context);
//         },
//         leading: Icon(Icons.add_box),
//         title: RichText(
//             text: TextSpan(
//                 text: suggestionList[index].substring(0, query.length),
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 children: [
//               TextSpan(
//                 text: suggestionList[index].substring(query.length),
//                 style: TextStyle(color: Colors.grey),
//               )
//             ])),
//       ),
//       itemCount: suggestionList.length,
//     );
//   }
// }
