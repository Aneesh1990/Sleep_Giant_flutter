import 'package:flutter/material.dart';
import 'package:sleep_giant/Generic/sharedHelper.dart';
import 'package:sleep_giant/Screens/Settings/change_password.dart';
import  'package:sleep_giant/Screens/Side_Menu/feed_back.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  bool isNotification = false;


  // <editor-fold desc=" Get payment state from diplaying upgrade option in the settings ">
  Future getPaymentStatus() async{
   return  await preference.getPaymentState();
  }
  // </editor-fold>

  // <editor-fold desc=" get sing in user data ">

  Future getUser() async{
    return  await preference.readUserModel("user");
  }

  // </editor-fold>


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Settings'),
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
      body: Container(
        color: Colors.white,
        child: ListView(
        children: <Widget>[
          SizedBox(height: 20,),
          Row(
            children: <Widget>[
              new Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                      border:  Border.all(color: Colors.transparent),
                      shape: BoxShape.rectangle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage('https://upload.wikimedia.org/wikipedia/en/b/b1/Portrait_placeholder.png')))),
              SizedBox(width: 10,),
              FutureBuilder(
                future: getUser(),
                  builder: (context,  snapshot){
                if (snapshot.hasData) {
                  return
                    Text(snapshot.requireData.email ?? "sample");
                } else {
                  return Container();
                }

              })

            ],
          ),
          SizedBox(height: 20,),
          
          FutureBuilder(
            future: getPaymentStatus(),
              builder: (context,snapshot){
            if (snapshot.hasData) {
              return snapshot.requireData ? Container(): Container(color: Colors.blueGrey,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Become Premium Member',style: TextStyle(color: Colors.white),),
                      SizedBox(width: 10,),
                      FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        color: Colors.transparent,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {},
                        child: Text(
                          "Upgrade",
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      )
                    ],
                  ),
                );
            } else {
              return Container();
            }

          }),

          ListTile(
            title: Text('Account',style: TextStyle(color: Colors.grey),),

          ),
          ListTile(
            title: Text('Change Password'),
            onTap: (){

              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ChangePassword()),
              );

            },
          ),
          Padding(padding: EdgeInsets.only(left:15,right: 15),child: Divider(color: Colors.grey,thickness: 0.5,),),
          SwitchListTile(
            title: const Text('App Notifications'),
            value: false,
            onChanged: (bool value) { setState(() { isNotification = value; }); },
          ),
          Padding(padding: EdgeInsets.only(left:15,right: 15),child: Divider(color: Colors.grey,thickness: 0.5,),),
          SwitchListTile(
            title: const Text('App Notification Sound'),
            value: false,
            onChanged: (bool value) { setState(() { isNotification = value; }); },
          ),
          Padding(padding: EdgeInsets.only(left:15,right: 15),child: Divider(color: Colors.grey,thickness: 0.5,),),
          ListTile(
            title: Text('Application',style: TextStyle(color: Colors.grey),),
          ),
          ListTile(
            title: Text('Send Feedback'),
            onTap: (){

              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => FeedBackApp()),
              );
            },

          ),
          Padding(padding: EdgeInsets.only(left:15,right: 15),child: Divider(color: Colors.grey,thickness: 0.5,),),
          ListTile(
            title: Text('Rate Us'),
          ),
          Padding(padding: EdgeInsets.only(left:15,right: 15),child: Divider(color: Colors.grey,thickness: 0.5,),),
          ListTile(
            title: Text('Share App'),
          ),

        ],
      ) ,) ,


    );
  }
}
