import 'package:flutter/material.dart';

class AppInfo extends StatefulWidget {
  @override
  _AppInfoState createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Image(
            image: AssetImage('assets/theme_bg.png'),
            fit: BoxFit.cover,
          ),
          title: Text(
            '',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios,
                color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body:Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/theme_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Sleep Giant',style: TextStyle(color: Colors.white,fontSize: 20.0)),
            SizedBox(height: 50,),
            Text('Version 1.0002',style: TextStyle(color: Colors.white)),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset("assets/tutorial_logo.png"),
            ),
            Text('Ignite Yourself LLC 2012 - 2020 all rights Reserved',style: TextStyle(color: Colors.grey),),
          ],

        ),
      ),
    ) ,) ;
  }


}
