import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class InfoDeltil extends StatefulWidget {
  final String title;

  const InfoDeltil({Key key, this.title}) : super(key: key);
  // InfoDeltil({Key? key}) : super(key: key);

  @override
  _InfoDeltilState createState() => _InfoDeltilState();
}

class _InfoDeltilState extends State<InfoDeltil> {
  List<String> images3 = [
    "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_3662-e1598935420456.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_3882-e1598937553211.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_3764-e1598940078290.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4678-e1598942607679.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_3961-e1598941945762.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4654-e1598939009945.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_3814-e1598935701820.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4533-e1598937813633.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4159-e1598940436540.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4494-e1598935090807.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_4195-e1598855929354.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_3722-e1598852830929.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_45901-e1598856583671.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4364-e1598939298188.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/11/Wayo-A..jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_4265-e1598855822484.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4138-e1598942042209.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_3697-e1598855869626.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/08/IMG_3939-e1598866440838.jpg",
    "https://www.moveforwardparty.org/wp-content/uploads/2020/09/IMG_4227-e1598938277746.jpg",
  ];
  List<String> title3 = [
    "พิธา ลิ้มเจริญรัตน์",
    "วรรณวิภา ไม้สน",
    "สุรเชษฐ์ ประวีณวงศ์วุฒิ",
    "พิจารณ์ เชาวพัฒนวงศ์",
    "อภิชาต ศิริสุนทร",
    "ศิริกัญญา ตันสกุล",
    "รังสิมันต์ โรม",
    "วินท์ สุธีรชัย",
    "สุเทพ อู่อ้น",
    "ปริญญา ช่วยเกตุ คีรีรัตน์",
    "ณัฐพล สืบศักดิ์วงศ์",
    "ธัญวัจน์ กมลวงศ์วัฒน์",
    "คารม พลพรกลาง",
    "สมชาย ฝั่งชลจิตร",
    "วาโย อัศวรุ่งเรือง",
    "คําพอง เทพาคํา",
    "อมรัตน์ โชคปมิตต์กุล",
    "สุพิศาล ภักดีนฤนาถ",
    "นิติพล ผิวเหมาะ",
    "วิโรจน์ ลักขณาอดิศร",
  ];

  Widget _buildItemList3(BuildContext context, int index) {
    if (index == title3.length)
      return Center(
        child: CircularProgressIndicator(),
      );
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => InfoDeltil(
        //             title: title3[index],
        //           )),
        // );
      },
      child: Container(
        width: 160.0,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Wrap(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: "${images3[index]}",
                placeholder: (context, url) =>
                    new Center(child: new CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    new Image.asset('images/placeholder.png'),
              ),
              // Image.network(
              //   images3[index],
              //   fit: BoxFit.cover,
              //   width: 200,
              //   height: 150,
              // ),
              ListTile(
                title: Center(
                    child: Text(title3[index],
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF47932),
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
                size: 14,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Color(0xffF47932),
          elevation: 0,
          centerTitle: true,
          title: Text(
            "สมาชิกสภาผู้แทนราษฎรแบบบัญชีรายชื่อ",
            style: TextStyle(
                color: Color(0xff0C3455),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  color: Color(0xffF47932),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? 3
                                    : 2,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 10,
                            childAspectRatio: (4 / 5),
                          ),
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: title3.length,
                          itemBuilder: (
                            BuildContext context,
                            int index,
                          ) {
                            return _buildItemList3(context, index);
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
