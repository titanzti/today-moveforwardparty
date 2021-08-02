import 'package:flutter/material.dart';

class ShareSC extends StatefulWidget {
  final String displayName1;
  final String ownerimageUrl;

  const ShareSC({Key key, this.displayName1, this.ownerimageUrl})
      : super(key: key);
  // const ShareSC({ Key? key }) : super(key: key);

  @override
  _ShareSCState createState() => _ShareSCState();
}

class _ShareSCState extends State<ShareSC> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    body: SizedBox.expand(
      child: DraggableScrollableSheet(
      initialChildSize: 0.3, //set this as you want
      maxChildSize: 0.13, //set this as you want
      minChildSize: 0.9, //set this as you want
      expand: true,
      builder: (context, scrollController) {
        return Container(
          child: ListView.builder(
            itemCount: 25,
            itemBuilder: (BuildContext context, int index) {
            return ListTile(title:Text("data$index"));
           },
          ),
        );//whatever you're returning, does not have to be a Container
      }
    ),
    ),
  );
    
    // Container(
    //     padding: EdgeInsets.all(10),
    //     // height: 250,
    //     // color: Colors.yellow,
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //        children: [
    //          Container(
    //           height: 250,

    //            child: ListView.builder(
    //              scrollDirection: Axis.vertical,
    //              itemCount: 10,
    //              itemBuilder: (BuildContext context, int index) {
    //              return ListTile(
    //   leading: Icon(Icons.account_circle),
    //   title: Text('Neil Armstrong'),
    //   onTap: (){
    //     Navigator.of(context).pushNamed("your_route_name");
    //   } ,
    // );
    //             },
    //            ),
    //          ),
    //       // Row(
    //       //   children: [
    //       //     Container(
    //       //       width: 50,
    //       //       height: 50,
    //       //       decoration: BoxDecoration(
    //       //         // border: Border.all(width: 4, color: Colors.white),
    //       //         boxShadow: [
    //       //           BoxShadow(
    //       //             spreadRadius: 2,
    //       //             blurRadius: 10,
    //       //             color: Colors.black.withOpacity(0.1),
    //       //           ),
    //       //         ],
    //       //         shape: BoxShape.circle,
    //       //         image: DecorationImage(
    //       //           fit: BoxFit.cover,
    //       //           image: new NetworkImage(
    //       //               "https://today-api.moveforwardparty.org/api${widget.ownerimageUrl}/image"),
    //       //         ),
    //       //       ),
    //       //     ),
    //       //     Text(
    //       //       widget.displayName1,
    //       //       style: TextStyle(
    //       //           color: Colors.black,
    //       //           fontSize: 16,
    //       //           fontWeight: FontWeight.bold),
    //       //     ),
    //       //   ],
    //       // ),
    //     ]));
  }
}
