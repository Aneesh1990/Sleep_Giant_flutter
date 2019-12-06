library generic;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sleep_giant/API%20Models/signup_response.dart';
import 'package:sleep_giant/Generic/sharedHelper.dart';

final Generic generic = Generic._private();

UserData userModel = UserData();
VoidCallback onTap;
final GlobalKey<State> _keyLoader = new GlobalKey<State>();

class Generic {
  Generic._private() ;

  // <editor-fold desc=" Get user model ">

  initUser() async {
    userModel = UserData.fromJson(await preference.readModel('user'));
  }

  // </editor-fold>

  // <editor-fold desc=" A global key for ">
  GlobalKey<State> keys() {
    return _keyLoader;
  }
  // </editor-fold>

  // <editor-fold desc=" unfocus existing from the current scaffold ">

  unFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  // </editor-fold>


  // <editor-fold desc=" General Alert Dialog ">

  alertDialog(
      BuildContext context, String heading, String body, VoidCallback _onTap) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(heading),
          content: new Text(body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
                onTap();
              },
            ),
          ],
        );
      },
    );
  }

  // </editor-fold>

  // <editor-fold desc=" Changing Focus on textField ">

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // </editor-fold>

  // <editor-fold desc=" Converter Duration to  time format  ">

  String getDurationFormattedString(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  // </editor-fold>

  // <editor-fold desc=" Find Wake up time from total minute ">
  String getWakeUpTargetTime(int totalMinute) {
    print(totalMinute);
    if (totalMinute == 0) return "x:xx am";
    var now = new DateTime.now();
    var sixtyDaysFromNow = now.add(new Duration(minutes: totalMinute));
    return new DateFormat.jm().format(sixtyDaysFromNow);
  }

// </editor-fold>

}

MyGlobals myGlobals = new MyGlobals();

class MyGlobals {
  GlobalKey _scaffoldKey;
  MyGlobals() {
    _scaffoldKey = GlobalKey();
  }
  GlobalKey get scaffoldKey => _scaffoldKey;
}

class User {
  // singleton
  static final User _singleton = User._internal();
  factory User() => _singleton;
  User._internal();
  static User get shared => _singleton;

  // variables
  UserData user;
  bool planStatus;
}
