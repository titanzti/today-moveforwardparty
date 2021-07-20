// import 'package:appmove/info.dart';
// import 'package:appmove/screen/home/HomeScreen.dart';
// import 'package:appmove/screen/loginandregister/Intro.dart';
// import 'package:appmove/screen/modle/Modelshop.dart';
// import 'package:appmove/screen/profile/Profile.dart';
// import 'package:appmove/screen/profile/Profiless.dart';
// import 'package:appmove/screen/support/Support.dart';
// import 'package:appmove/ttt.dart';
// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// class TTt extends StatefulWidget {
//   final bool islogin;
//   final String mytoken;

//   const TTt({Key key, this.islogin, this.mytoken}) : super(key: key);

//   @override
//   _TTtState createState() => _TTtState();
// }

// class _TTtState extends State<TTt> {
//   int currentTab = 0;
//   int currentIndex = 0;
//   @override
//   void initState() {
//     setState(() {
//     });
//     super.initState();
//   }

//   List listOfColors = [
//     Info(),
//     Support(),
//     HomeScreen(),
//     Modelshop(),
//     Profile(),
    
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(
//       //     'Animated NavBar',
//       //     style: TextStyle(
//       //       color: Colors.cyanAccent,
//       //     ),
//       //   ),
//       //   backgroundColor: Colors.red,
//       // ),
//       body: listOfColors[currentIndex],

//       bottomNavigationBar: BottomNavyBar(
        
//         selectedIndex: currentIndex,
//         onItemSelected: (index) {
//           setState(() {
//             currentIndex = index;
//             print(currentIndex);
//             if (currentIndex == 4) {

//               if (widget.mytoken == null) {
//                 showCupertinoModalBottomSheet(
//                   context: context,
//                   builder: (context) => Intro(),
//                 );
//               }
//               // if (widget.islogin != null) {
//               //   showCupertinoModalBottomSheet(
//               //     context: context,
//               //     builder: (context) => Profile(),
//               //   );
//               // }
//         //       if (widget.islogin == true) {
//         //                           Navigator.push(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => Profile()),
//         // );
//         //       }
//               print('เลข2');
//             }
//           });
//         },
//         items: <BottomNavyBarItem>[
//           BottomNavyBarItem(
//             icon: Icon(
//               Icons.supervisor_account_outlined,
//               color: currentTab == 0 ? Color(0xffF47932) : Colors.grey,
//             ),
//             title: Text('นักอุดมคติ'),
//             activeColor: Color(0xff0C3455),
//           ),
//           BottomNavyBarItem(
//             icon: Icon(
//               Icons.card_giftcard,
//               color: currentTab == 0 ? Color(0xffF47932) : Colors.grey,
//             ),
//             title: Text('บริจาค'),
//             activeColor: Color(0xff0C3455),
//           ),
//           BottomNavyBarItem(
//             icon: new Icon(Icons.home_outlined),

//             title: Text('Home'),
        
            
//             // Icon(
//             //   Icons.shop_outlined,
//             //   color: currentTab == 0 ? Color(0xffF47932) : Colors.grey,
//             // ),
//             // title: Text(''),
//             // activeColor: Color(0xff0C3455),
//           ),
//           BottomNavyBarItem(
//             icon: Icon(
//               Icons.shop_outlined,
//               color: currentTab == 0 ? Color(0xffF47932) : Colors.grey,
//             ),
//             title: Text('ร้านค้า'),
//             activeColor: Color(0xff0C3455),
//           ),
//           BottomNavyBarItem(
//             icon: Icon(
//               Icons.person,
//               color: currentTab == 0 ? Color(0xffF47932) : Colors.grey,
//             ),
//             title: Text('โปรไฟล์'),
//             activeColor: Color(0xff0C3455),
//             inactiveColor: Colors.grey,
//           ),
//         ],
//       ),
//     );
//   }
// }
