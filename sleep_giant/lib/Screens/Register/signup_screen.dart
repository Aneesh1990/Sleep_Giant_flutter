import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:regexed_validator/regexed_validator.dart';

import 'package:sleep_giant/API%20Models/signup_request.dart';
import 'package:sleep_giant/API/api_helper.dart';
import 'package:sleep_giant/Generic/generic_helper.dart';
import 'package:sleep_giant/Generic/sharedHelper.dart';
import 'package:sleep_giant/Screens/Side_Menu/info_screen.dart';
import 'package:sleep_giant/Screens/sleep_deck.dart';
import 'package:sleep_giant/Style/colors.dart';

class SGSignUpScreen extends StatefulWidget {
  @override
  _SGSignUpScreenState createState() => _SGSignUpScreenState();
}

class _SGSignUpScreenState extends State<SGSignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/theme_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: _registerForm()),
      ),
    );
  }

  // <editor-fold desc=" Registration form UI">

  Widget _registerForm() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new IconButton(
                    icon:
                        new Icon(Icons.arrow_back_ios, color: AppColors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Image.asset("assets/tutorial_logo.png"),
            ),
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
                      focusNode: _nameFocus,
                      onFieldSubmitted: (term) {
                        generic.fieldFocusChange(
                            context, _nameFocus, _emailFocus);
                      },
                      style: TextStyle(color: AppColors.white),
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
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
                      autovalidate: false,
                      autocorrect: false,
                      validator: (value) {
                        if (!validator.name(value) && value.isNotEmpty) {
                          return 'Please enter valid name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                        focusNode: _emailFocus,
                        onFieldSubmitted: (term) {
                          generic.fieldFocusChange(
                              context, _emailFocus, _passwordFocus);
                        },
                        style: TextStyle(color: AppColors.white),
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
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
                        autovalidate: true,
                        autocorrect: false,
                        validator: (value) {
                          if (!validator.email(value) && value.isNotEmpty) {
                            return 'Please enter valid email address';
                          }
                          return null;
                        }),
                    TextFormField(
                        focusNode: _passwordFocus,
                        onFieldSubmitted: (term) {
                          generic.fieldFocusChange(
                              context, _passwordFocus, _confirmPasswordFocus);
                        },
                        style: TextStyle(color: AppColors.white),
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
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
                    Container(
                      height: 50,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.white12,
                        child: Text('SIGN UP',
                            style: TextStyle(color: AppColors.white)),
                        onPressed: () {
                          if (_nameController.text.isEmpty ||
                              _emailController.text.isEmpty ||
                              _passwordController.text.isEmpty ||
                              _confirmPasswordController.text.isEmpty) {
                            generic.alertDialog(context, "Missing Fields",
                                "Please fill all the fields", () {});
                          } else if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            generic.alertDialog(
                                context,
                                "Password doesn't match",
                                "Please enter same password",
                                () {});
                          } else if (validator.email(_emailController.text) &&
                              validator.password(_passwordController.text) &&
                              validator
                                  .password(_confirmPasswordController.text)) {
                            _onSubmit();
                          }
                        },
                      ),
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

  // </editor-fold>

  // <editor-fold desc=" Network - call ">

  _onSubmit() async {
    Dialogs.showLoadingDialog(context, generic.keys());
    generic.unFocus(context);
    SignUpRequest request = SignUpRequest(
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        name: _nameController.text);
    await ApiBaseHelper().userSignUp(request).then((response) {
      Navigator.of(generic.keys().currentContext, rootNavigator: true).pop();
      if (response.status == 1) {
        preference.setLoginState(true);
        preference.sharedPreferencesSet("token", response.token);
        preference.saveModel('user', response.userData);
        User.shared.user = response.userData;
        User.shared.planStatus = response.userData.planId == 1 ? false : true;

        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => OnBoardingPage()),
        );
      } else {
        generic.alertDialog(context, 'Alert', response.error, () {});
      }
    });
  }

// </editor-fold>
}
