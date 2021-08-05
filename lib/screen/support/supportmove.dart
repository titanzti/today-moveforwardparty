import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Supportmove extends StatefulWidget {
  @override
  _SupportmoveState createState() => _SupportmoveState();
}

class _SupportmoveState extends State<Supportmove> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: "https://donation.moveforwardparty.org/donation/",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
