import 'package:flutter/material.dart';

class Modelshop extends StatefulWidget {
  @override
  _ModelshopState createState() => _ModelshopState();
}

class _ModelshopState extends State<Modelshop> {
  Container listshop(String listshop) {
    return Container(
      child: RaisedButton(
          color: Colors.white,
          child: Text(
            listshop,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          onPressed: () {},
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF47932),
      body: ListView(
        children: [
          Container(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'รายการสินค้า',
              style: TextStyle(
                color: Color(0xff0C3455),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 20.0,
              runSpacing: 10.0,
              children: <Widget>[
                listshop("สินค้าใหม่"),
                listshop("เสื้อ"),
                listshop("หมวก"),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(10),
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 17),
                      blurRadius: 23,
                      spreadRadius: -13,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                      width: 60,
                      child: Image.asset(
                        'images/logofb.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "เสื้อยืด",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            "รายละเอียดเพิ่มเติม",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            '450 บาท',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          'images/logofb.png',
                          fit: BoxFit.cover,
                        ),
                      ), // child: SvgPicture.asset("assets/icons/Lock.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(10),
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 17),
                      blurRadius: 23,
                      spreadRadius: -13,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    // SvgPicture.asset(
                    //   "assets/icons/Meditation_women_small.svg",
                    // ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "เสื้อยืด",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            "รายละเอียดเพิ่มเติม",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            '450 บาท',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons
                          .add), // child: SvgPicture.asset("assets/icons/Lock.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(10),
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 17),
                      blurRadius: 23,
                      spreadRadius: -13,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    // SvgPicture.asset(
                    //   "assets/icons/Meditation_women_small.svg",
                    // ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "เสื้อยืด",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            "รายละเอียดเพิ่มเติม",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            '450 บาท',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons
                          .add), // child: SvgPicture.asset("assets/icons/Lock.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(10),
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 17),
                      blurRadius: 23,
                      spreadRadius: -13,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    // SvgPicture.asset(
                    //   "assets/icons/Meditation_women_small.svg",
                    // ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "เสื้อยืด",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            "รายละเอียดเพิ่มเติม",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            '450 บาท',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons
                          .add), // child: SvgPicture.asset("assets/icons/Lock.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
