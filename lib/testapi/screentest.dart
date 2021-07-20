import 'package:appmove/model/testmoel.dart';
import 'package:appmove/testapi/API.dart';
import 'package:flutter/material.dart';

class ScreenTest extends StatefulWidget {

  @override
  _ScreenTestState createState() => _ScreenTestState();
}


class _ScreenTestState extends State<ScreenTest> {
  @override
  void initState() { 
    super.initState();
        Api.randomDog();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
          // title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                  future: Api.randomDog(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      MessageDogsDao msg = snapshot.data;
                      print("snap = "+msg.message);
                      return Image.network(msg.message,width: 300,height: 200,);
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
            ],
          ),
        ));
  }
}