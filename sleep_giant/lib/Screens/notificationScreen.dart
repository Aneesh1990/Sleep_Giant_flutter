import 'package:flutter/material.dart';
import 'package:sleep_giant/API%20Models/notification_response_model.dart';
import 'package:sleep_giant/API/api_helper.dart';
import 'package:sleep_giant/Generic/generic_helper.dart';
import 'package:sleep_giant/Screens/sleep_deck.dart';
import 'package:sleep_giant/Style/colors.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationData> notificationData = [];
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  // <editor-fold desc=" Net work - call">

  _fetchNotification() async {
    Dialogs.showLoadingDialog(context, _keyLoader);

    await ApiBaseHelper().getNotification().then((response) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (response.status == 1) {
        setState(() {
          notificationData = response.notificationData;
        });
      } else {
        generic.alertDialog(context, 'Alert', response.toString(), () {});
      }
    });
  }

  // </editor-fold">

  @override
  void initState() {
    // TODO: implement initState

    _fetchNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Notifications"),
            flexibleSpace: Image(
              image: AssetImage('assets/theme_bg.png'),
              fit: BoxFit.cover,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.orange),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        body: notificationData.isEmpty
            ? Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/theme_bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    'No notification found',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              )
            : Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/theme_bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ));
  }
}
