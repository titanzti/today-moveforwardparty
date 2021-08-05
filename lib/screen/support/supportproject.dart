import 'package:appmove/main.dart';
import 'package:appmove/screen/profile/Editprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Supportproject extends StatefulWidget {
  @override
  _SupportprojectState createState() => _SupportprojectState();
}

class _SupportprojectState extends State<Supportproject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: "https://projectdonation.moveforwardparty.org/",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
