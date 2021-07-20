import 'package:flutter/material.dart';
import 'package:meta/meta_meta.dart';

class Support extends StatefulWidget {
  

  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Color(0xffF47932),
        title: Text('Support'),
      ),
    );
  }
}