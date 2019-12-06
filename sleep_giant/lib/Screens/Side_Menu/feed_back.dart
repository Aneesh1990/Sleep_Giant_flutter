import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:sleep_giant/API%20Models/profile_update.dart';

import 'package:sleep_giant/API%20Models/signup_response.dart';
import 'package:sleep_giant/API/api_helper.dart';

import 'package:sleep_giant/Generic/generic_helper.dart';
import 'package:sleep_giant/Generic/sharedHelper.dart';
import 'package:sleep_giant/Screens/sleep_deck.dart';

class FeedBackApp extends StatefulWidget {
  @override
  _FeedBackAppState createState() => _FeedBackAppState();
}

class _FeedBackAppState extends State<FeedBackApp> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedController = TextEditingController();



  final FocusNode _emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Image(
            image: AssetImage('assets/theme_bg.png'),
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            FlatButton.icon(
              color: Colors.transparent,
              icon: Icon(Icons.check,color:Colors.white), //`Icon` to display
              label: Text("",style:TextStyle(color:Colors.white)), //`Text` to display
              onPressed: () async {
                //Code to execute when Floating Action Button is clicked
                //...
                if (_emailController.text.isEmpty) {
                  generic.alertDialog(context, "Missing Fields",
                      "Please fill all the details.",(){});
                } else {

                  _onSubmit();
                }
              },
            ),
          ],
          title: Text(
            'Send Feedback',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios,
                color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: Center(
        child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/theme_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: feedbackForm()),
      ),
    );
  }


  // <editor-fold desc=" Feedback Form">

  Widget feedbackForm() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Card(
              color: Colors.white12,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[

                    TextFormField(
                        focusNode: _emailFocus,
                        onFieldSubmitted: (term) {
                         _emailFocus.unfocus();
                        },
                        style: TextStyle(color: Colors.white),
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54),
                          ),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54)),
                        ),
                        obscureText: true,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (value){
                          if (!validator.email(value) && value.isNotEmpty ){
                            return 'Enter valid password';
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 10,),
                   TextField(
                     decoration: new InputDecoration.collapsed(
                         hintText: 'Write a brief',
                         hintStyle: TextStyle(color: Colors.white)


                     ),
                     style: TextStyle(color:Colors.white),
                     controller: _feedController,
                     textInputAction: TextInputAction.newline,
                     keyboardType: TextInputType.multiline,
                     maxLines: 15,
                   ),
                    SizedBox(height: 10,),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // </editor-fold>

  // <editor-fold desc=" Feed back from submission">
  _onSubmit() async{


  }
// </editor-fold>
}
