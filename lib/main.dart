import 'package:appmove/screen/home/NavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var status = prefs.getBool('isLoggedIn') ?? false;
  // print(status);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    // FutureBuilder(
    //     future: SharedPreferences.getInstance(),
    //     builder:
    //         (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
    //       var isloggedIn = prefs.data;
    //       // final bool isloginn = isloggedIn.getBool('isLoggedIn');
    //       //  String istoken = isloggedIn.getString("token")??"";
    //       //            String mytoken = isloggedIn.getString("myuid")??"";


    //       if (prefs.hasData) {
    //         // if (x.getString('type') == 'doctor') {
    //            return MaterialApp(
    //               debugShowCheckedModeBanner: false,
    //               home: Appbar());
    //         // if (istoken == null || istoken == "") {
             
    //         // } else {
    //         //   return MaterialApp(
    //         //       debugShowCheckedModeBanner: false,
    //         //       home: Appbar(istoken: istoken,myuid: mytoken,));
    //         // }
    //       }

    //       return SpScreen();
    //     });
       MaterialApp(
      // darkTheme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Appbar(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Appbar()),
//                 );
//               },
//               tooltip: 'Increment',
//               icon: Icon(Icons.add),
//             ),
//             Text('test'),
//             IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SpScreen()),
//                 );
//               },
//               tooltip: 'Increment',
//               icon: Icon(Icons.add),
//             ),
//             Text('Spscreen'),
//             IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Intro()),
//                 );
//               },
//               tooltip: 'Increment',
//               icon: Icon(Icons.add),
//             ),
//             Text('Intro'),
//             IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ProfilessScreen()),
//                 );
//               },
//               tooltip: 'Increment',
//               icon: Icon(Icons.add),
//             ),
//             Text('Profiless'),
//           ],
//         ),
//       ),
//     );
//   }
// }
