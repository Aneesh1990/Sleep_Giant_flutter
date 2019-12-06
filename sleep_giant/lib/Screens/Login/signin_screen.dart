import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:regexed_validator/regexed_validator.dart';
import 'package:sleep_giant/API%20Models/signin_request.dart';

import 'package:sleep_giant/API/api_helper.dart';
import 'package:sleep_giant/Generic/generic_helper.dart';



import 'package:sleep_giant/Generic/sharedHelper.dart';
import 'package:sleep_giant/Screens/Login/forgot_password.dart';

import 'package:sleep_giant/Screens/Register/signup_screen.dart';
import 'package:sleep_giant/Screens/sleep_deck.dart';
import 'package:sleep_giant/Style/colors.dart';

class SGSignInScreen extends StatefulWidget {
  @override
  _SGSignInScreenState createState() => _SGSignInScreenState();
}

class _SGSignInScreenState extends State<SGSignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/theme_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
//              mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
          // physics: ClampingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("assets/tutorial_logo.png"),
              ),
              Container(
                  color: Colors.white12,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'SIGN IN',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            focusNode: _emailFocus,
                            onFieldSubmitted: (term) {
                              generic.fieldFocusChange(context, _emailFocus, _passwordFocus);
                            },
                            style: TextStyle(color: AppColors.white),
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              labelStyle: TextStyle(color: AppColors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white54),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white54),
                              ),
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
                            ),
                            autovalidate: true,
                            autocorrect: false,
                            validator: (value) {
                              if (!validator.email(value) &&
                                  value.isNotEmpty) {
                                return 'Please enter valid email address';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            focusNode: _passwordFocus,
                              onFieldSubmitted: (value){
                                _passwordFocus.unfocus();

                              },
                              style: TextStyle(color: AppColors.white),
                              controller: _passwordController,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                  wordSpacing: 5.0,
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: AppColors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white54),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white54),
                                ),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white54)),
                              ),
                              obscureText: true,
                              autovalidate: true,
                              autocorrect: false,
                              validator: (value) {
                                if (!validator.password(value) &&
                                    value.isNotEmpty) {
                                  return 'Enter valid password';
                                }
                                return null;
                              }),
                        ),
                        Divider(
                          height: 15,
                        ),
                        InkWell(onTap: (){

                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => ForgotPassword()),
                          );
                        },
                          child: Text('Forgot Password?',style: TextStyle(color: AppColors.white),),),
                        Divider(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 40,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Colors.white12,
                                child: Text('SIGN IN',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  if (_emailController.text.isEmpty) {
                                    generic.alertDialog(
                                        context,
                                        'Missing Field',
                                        "Please enter a email address",(){});
                                  } else if (_passwordController
                                      .text.isEmpty) {
                                    generic.alertDialog(
                                        context,
                                        'Missing Field',
                                        "Please enter a password",(){});
                                  } else if (validator
                                          .email(_emailController.text) &&
                                      validator.password(
                                          _passwordController.text)) {

                                    _onSubmit();

//                                      generic.check().then((intenet) {
//                                        if (intenet != null && intenet) {
//                                          // Internet Present Case
//                                          _onSubmit();
//                                        }else{
//                                          generic.alertDialog(context, "Appeared offline","You don't have Active intenet connection");
//                                          // No-Internet Case
//                                        }
//
//                                      });

                                  }
                                },
                              ),
                            ),
                            Divider(
                              height: 15,
                            ),
                            Text(
                              "Don't have an account?",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white54),
                            ),
                      SizedBox(height: 10,),
                            Container(
                              height: 40,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Colors.white12,
                                child: Text('SIGN UP',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return SGSignUpScreen();
                                    }),
                                  );
                                },
                              ),
                            ),
                            Divider(
                              height: 15,
                            ),
                            Text(
                              "© 2019 by Sleep Giant",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          )),
    );
  }

  // <editor-fold desc=" Network - call ">

  _onSubmit() async {
    Dialogs.showLoadingDialog(context, generic.keys());

    SignInRequest request = SignInRequest(
      email: _emailController.text,
      password: _passwordController.text,
    );
    await ApiBaseHelper().userSignIn(request).then((response) {
      Navigator.of(generic.keys().currentContext,rootNavigator: true).pop();
      if (response.status == 1) {
         preference.setPaymentState(response.userData.planId == 1 ? false:true);
        preference.setLoginState(true);
        preference.sharedPreferencesSet("token", response.token);
        preference.saveModel('user', response.userData);
        User.shared.user = response.userData;
        User.shared.planStatus = response.userData.planId == 1 ? false:true;

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      } else {
        generic.alertDialog(context, 'Alert', response.error,(){});
      }
    });
  }
// </editor-fold>
}
