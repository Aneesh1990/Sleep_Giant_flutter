import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:sleep_giant/API%20Models/profile_update.dart';
import 'package:sleep_giant/API%20Models/signup_response.dart';
import 'package:sleep_giant/API/api_helper.dart';
import 'package:sleep_giant/Generic/generic_helper.dart';
import 'package:sleep_giant/Generic/sharedHelper.dart';
import 'package:sleep_giant/Screens/sleep_deck.dart';
import 'package:sleep_giant/Style/colors.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            FlatButton.icon(
              color: Colors.transparent,
              icon: Icon(
                Icons.check,
                color: AppColors.white,
              ), //`Icon` to display
              label: Text(""), //`Text` to display
              onPressed: () async {
                //Code to execute when Floating Action Button is clicked
                //...
                if (_passwordController.text.isEmpty &&
                    _confirmPasswordController.text.isEmpty) {
                  generic.alertDialog(context, "Missing Fields",
                      "Please fill all the details.", () {});
                } else {
                  _onSubmit();
                }
              },
            ),
          ],
          title: Text(
            'New Password',
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: AppColors.white),
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
            child: changePasswordForm()),
      ),
    );
  }

  Widget changePasswordForm() {
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
                        focusNode: _passwordFocus,
                        onFieldSubmitted: (term) {
                          generic.fieldFocusChange(
                              context, _passwordFocus, _confirmPasswordFocus);
                        },
                        style: TextStyle(color: AppColors.white),
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'New Password',
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
                        obscureText: true,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (value) {
                          if (!validator.password(value) && value.isNotEmpty) {
                            return 'Enter valid password';
                          }
                          return null;
                        }),
                    TextFormField(
                        focusNode: _confirmPasswordFocus,
                        onFieldSubmitted: (term) {
                          _confirmPasswordFocus.unfocus();
                        },
                        style: TextStyle(color: AppColors.white),
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
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
                        obscureText: true,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (value) {
                          print(value);
                          if (!validator.password(value) && value.isNotEmpty) {
                            return 'Enter valid password';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // <editor-fold desc=" Network - call ">
  _onSubmit() async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    generic.unFocus(context);

    UserData userModel = UserData.fromJson(await preference.readModel('user'));

    ProfileUpdate profileUpdate = ProfileUpdate(
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        name: userModel.name,
        email: userModel.email);

    await ApiBaseHelper().userProfileUpdate(profileUpdate).then((response) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (response.status == 1) {
      } else {
        generic.alertDialog(context, 'Alert', response.error, () {});
      }
    });
  }

// </editor-fold>
}
