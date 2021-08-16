
import 'package:flutter/material.dart';


class SpScreen extends StatefulWidget {
 
  @override
  _SpScreenState createState() => _SpScreenState();
}

class _SpScreenState extends State<SpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text('พรรคก้าวไกล',style: TextStyle(
             color: Color(0xff0C3455),
              fontWeight: FontWeight.bold,
              fontSize: 28),),
           Image.asset('images/logo.png',height: 300,width: 500,),
            SizedBox(
              height: 20,
            ),
            // CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            // )
          ],
        ),
      ),
    );
  }
}