import 'package:flutter/material.dart';
import 'package:sleep_giant/Generic/sharedHelper.dart';
import 'package:sleep_giant/Screens/Side_Menu/app_info.dart';
import 'package:sleep_giant/Screens/Side_Menu/feed_back.dart';
import 'package:sleep_giant/Screens/Home/home_screen.dart';
import 'package:sleep_giant/Screens/Side_Menu/info_screen.dart';
import 'package:sleep_giant/Screens/intro_screen.dart';
import 'package:sleep_giant/Screens/Login/signin_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  //<editor-fold desc=" Build Function ">
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
          canvasColor: Colors.black45
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: preference.getLoginState(),
          builder:(BuildContext context, AsyncSnapshot<bool> snapshot){
            return snapshot.hasData ?  buildRout(snapshot.data): Container() ;
          }
      ),
      routes:<String, WidgetBuilder>{
        '/root': (BuildContext context) => new SGSignInScreen(),
        '/home': (BuildContext context) => new HomeScreen(),
        '/intro': (BuildContext context) => IntroScreen(),

      } ,
    );
  }
  //</editor-fold>

  //<editor-fold desc=" App keep login status check and navigate to corresponding screen ">
  Widget buildRout(bool status){
    if (status){
      return HomeScreen();
    }else{
      return SGSignInScreen();
    }


  }
  //</editor-fold>
}
