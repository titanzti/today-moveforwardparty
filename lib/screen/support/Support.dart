import 'package:appmove/screen/support/supportmove.dart';
import 'package:appmove/screen/support/supportproject.dart';
import 'package:flutter/material.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  List<Widget> body = [
    Supportmove(),
    Supportproject(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF47932),
          bottom: TabBar(
            tabs: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'สนับสนุนพรรค',
                  style: TextStyle(
                      color: Color(0xff0C3455),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Text(
                'สนับสนุนโครงการ',
                style: TextStyle(
                    color: Color(0xff0C3455),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: body,
        ),
      ),
    );
  }
}
