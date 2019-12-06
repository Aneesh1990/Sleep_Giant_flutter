import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:regexed_validator/regexed_validator.dart';

import 'package:sleep_giant/API%20Models/signin_request.dart';

import 'package:sleep_giant/API/api_helper.dart';
import 'package:sleep_giant/Generic/generic_helper.dart';

import 'package:sleep_giant/Screens/sleep_deck.dart';
import 'package:sleep_giant/Style/colors.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();


  final TextEditingController _passwordController = TextEditingController();



  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            FlatButton.icon(
              color: Colors.transparent,
              icon: Icon(Icons.check,color: AppColors.white,), //`Icon` to display
              label: Text(""), //`Text` to display
              onPressed: () async {
                //Code to execute when Floating Action Button is clicked
                //...
                if (_passwordController.text.isEmpty
                    ) {
                  generic.alertDialog(context, "Missing Fields",
                      "Please fill all the details.",(){});
                } else {

                  _onSubmit();





                }
              },
            ),
          ],
          title: Text(
            'Reset Password',
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios,
                color: AppColors.white),
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
            child: forgotPasswordForm()),
      ),
    );
  }


  // <editor-fold desc=" forgot password form ">
  Widget forgotPasswordForm() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  TextFormField(
                      focusNode: _passwordFocus,
                      onFieldSubmitted: (term) {
                        generic.fieldFocusChange(context,_passwordFocus,_confirmPasswordFocus);
                      },
                      style: TextStyle(color: AppColors.white),
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Your Email Address',
                        labelStyle: TextStyle(color: AppColors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54)),
                      ),
                      obscureText: false,
                      autovalidate: true,
                      autocorrect: false,
                      validator: (value){
                        if (!validator.email(value) && value.isNotEmpty ){
                          return 'Enter valid email';
                        }
                        return null;
                      }
                  ),
                  Divider(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // </editor-fold">

  // <editor-fold desc=" Network call">

  _onSubmit() async{
    Dialogs.showLoadingDialog(context, _keyLoader);
   // generic.unFocus(context);
    SignInRequest request = SignInRequest(
      email: _passwordController.text,
      password: "",
    );

    await ApiBaseHelper().resetPassword(request).then((response) {
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
      if (response.statusCode == 200){

        ForgotResponse forgotResponse = ForgotResponse.fromJson(json.decode(response.body));
        generic.alertDialog(context,'Alert',forgotResponse.message,(){});

       Navigator.of(context).pop();

      }else{
        generic.alertDialog(context,'Alert','Something went wrong',(){});
      }
    });

  }
// </editor-fold>
}

class ForgotResponse {
  int status;
  String message;
  int userId;

  ForgotResponse({this.status, this.message, this.userId});

  ForgotResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    return data;
  }
}

