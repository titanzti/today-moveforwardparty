import 'package:appmove/info.dart';
import 'package:appmove/screen/home/HomeScreen.dart';
import 'package:appmove/screen/home/Sp%20Screen.dart';
import 'package:appmove/screen/home/appbar.dart';
import 'package:appmove/screen/loginandregister/Intro.dart';
import 'package:appmove/screen/loginandregister/Login.dart';
import 'package:appmove/screen/loginandregister/Register.dart';
import 'package:appmove/screen/profile/Profiless.dart';
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
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
          var isloggedIn = prefs.data;
          // final bool isloginn = isloggedIn.getBool('isLoggedIn');
          final String istoken = isloggedIn.getString("token");

          if (prefs.hasData) {
            // if (x.getString('type') == 'doctor') {
            if (istoken == null || istoken == "") {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Appbar(istoken: istoken));
            } else {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Appbar(
                    istoken: istoken,
                  ));
            }
          }

          return SpScreen();
        });
    //    MaterialApp(
    //   title: 'Flutter Demo',
    //   // darkTheme: ThemeData(brightness: Brightness.dark),
    //   theme: ThemeData(
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   debugShowCheckedModeBanner: false,
    //   home: TTt(),
    // );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Appbar()),
                );
              },
              tooltip: 'Increment',
              icon: Icon(Icons.add),
            ),
            Text('test'),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpScreen()),
                );
              },
              tooltip: 'Increment',
              icon: Icon(Icons.add),
            ),
            Text('Spscreen'),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Intro()),
                );
              },
              tooltip: 'Increment',
              icon: Icon(Icons.add),
            ),
            Text('Intro'),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilessScreen()),
                );
              },
              tooltip: 'Increment',
              icon: Icon(Icons.add),
            ),
            Text('Profiless'),
          ],
        ),
      ),
    );
  }
}
