// import 'package:appmove/screen/modle/Modelshop.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int _currentIndex = 0;
//   String test;

//   final List<Widget> _pages = [
//     Info(),
//     Support(),
//   Modelshop(),
//     Intro(),
//   ];

//   void onTabTapped(int index) {
//     HapticFeedback.lightImpact();

//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bottomNavBar = BottomNavigationBar(
//       onTap: onTabTapped,
//       currentIndex: _currentIndex,
//       selectedItemColor: primaryColor,
//       unselectedItemColor: Colors.blueGrey.withOpacity(0.6),
//       elevation: 0.0,
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_outlined),
//           title: Text(
//             'Feed',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.supervised_user_circle_outlined),
//           title: Text(
//             'Category',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.notifications_outlined),
//           title: Text(
//             'Notifications',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           title: Text(
//             'Profile',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );

//     return Scaffold(
//       bottomNavigationBar: bottomNavBar,
//       body: _pages[_currentIndex],
//     );
//   }
// }
