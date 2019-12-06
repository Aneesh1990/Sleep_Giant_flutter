import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sleep_giant/API%20Models/all_programs_list_response.dart';

import 'package:sleep_giant/API/api_helper.dart';
import 'package:sleep_giant/Generic/generic_helper.dart';
import 'package:sleep_giant/Generic/sharedHelper.dart';
import 'package:sleep_giant/Screens/Settings/settings.dart';
import 'package:sleep_giant/Screens/Side_Menu/app_info.dart';

import 'package:sleep_giant/Screens/Side_Menu/info_screen.dart';
import 'package:sleep_giant/Screens/music_list.dart';
import 'package:sleep_giant/Screens/notificationScreen.dart';
import 'package:sleep_giant/Screens/Side_Menu/purchase_screen.dart';

import 'package:sleep_giant/Screens/sleep_deck.dart';
import 'package:sleep_giant/Style/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AllProgramsResponse allPrograms;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Future getPaymentStatus() async {
    return await preference.getPaymentState();
  }

  Future getUser() async {
    return await preference.readUserModel("user");
  }

  // <editor-fold desc=" Network call ">
  getAllPrograms() async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await ApiBaseHelper().getAllPrograms().then((response) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (response.status == 1) {
        print(response.toJson());
        allPrograms = response;
      } else {
        generic.alertDialog(context, 'Alert', "Something went wrong", () {});
      }
    });
  }
  // </editor-fold>

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllProgramsRequestSend();
  }

  // <editor-fold desc="Get all program ">
  getAllProgramsRequestSend() async {
    await Future.delayed(const Duration(seconds: 1), () {
      getAllPrograms();
    });
  }
  // </editor-fold>

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Color(0xFF080808), Color(0xFF190060)],
                  begin: const FractionalOffset(0.0, 0.5),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/home_bg.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (allPrograms == null) {
                              generic.alertDialog(context, 'Alert',
                                  'Something went wrong', () {});
                              return;
                            }

                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return MusicList(
                                  programTypeData:
                                      allPrograms.programtypeData[0],
                                );
                              }),
                            );
                          },
                          child: Container(
                            child: Stack(
                              children: <Widget>[
                                Image.asset('assets/wind_down.png'),
                                Positioned(
                                  bottom: 20.0,
                                  left: 0,
                                  right: 0,
                                  child: Align(
                                    child: Text(
                                      "Wind Down",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
//                          allPrograms

                            if (allPrograms == null) {
                              generic.alertDialog(context, 'Alert',
                                  'Something went wrong', () {});
                              return;
                            }

                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return MusicList(
                                  programTypeData:
                                      allPrograms.programtypeData[1],
                                );
                              }),
                            );
                          },
                          child: Container(
                              child: Stack(
                            children: <Widget>[
                              Image.asset('assets/sleep_deep.png'),
                              Positioned(
                                bottom: 20.0,
                                left: 0,
                                right: 0,
                                child: Align(
                                  child: Text(
                                    "Sleep Deep",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
//                          allPrograms
                            if (allPrograms == null) {
                              generic.alertDialog(context, 'Alert',
                                  'Something went wrong', () {});
                              return;
                            }

                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return MusicList(
                                  programTypeData:
                                      allPrograms.programtypeData[2],
                                );
                              }),
                            );
                          },
                          child: Container(
                              child: Stack(
                            children: <Widget>[
                              Image.asset('assets/nap_recovery.png'),
                              Positioned(
                                bottom: 20.0,
                                left: 0,
                                right: 0,
                                child: Align(
                                  child: Text(
                                    "Nap Recovery",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                        InkWell(
                          onTap: () {
//                         allPrograms
                            if (allPrograms == null) {
                              generic.alertDialog(context, 'Alert',
                                  'Something went wrong', () {});
                              return;
                            }

                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return MusicList(
                                  programTypeData:
                                      allPrograms.programtypeData[3],
                                );
                              }),
                            );
                          },
                          child: Container(
                              child: Stack(
                            children: <Widget>[
                              Image.asset('assets/wake_up.png'),
                              Positioned(
                                bottom: 20.0,
                                left: 0,
                                right: 0,
                                child: Align(
                                  child: Text(
                                    "Wake Up",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 65.0, right: 65.0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color.fromRGBO(194, 45, 255, 1),
                        child: Text('Go to Sleep Deck',
                            style: TextStyle(color: AppColors.white)),
                        onPressed: () {
                          if (allPrograms == null) {
                            generic.alertDialog(context, 'Alert',
                                'Something went wrong', () {});
                            return;
                          }

                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return SleepDeck(
                                programTypeData: allPrograms.programtypeData,
                                sleepDecks: allPrograms.sleepDecks,
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                child: Image.asset("assets/torch.png"),
                onTap: () {},
              )),
          Positioned(
            top: 10,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.dehaze),
              color: AppColors.white,
              onPressed: () {
                _scaffoldKey.currentState.openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: buildDrawer(context),
    ));
  }

  // <editor-fold desc=" Drawer building">
  buildDrawer(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/theme_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    ListTile(
                      title: Image.network(
                        'https://upload.wikimedia.org/wikipedia/en/b/b1/Portrait_placeholder.png',
                        width: 100,
                        height: 100,
                      ),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: FutureBuilder(
                          future: getUser(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.requireData.email ?? "sample",
                                style: TextStyle(color: AppColors.white),
                              );
                            } else {
                              return Text('');
                            }
                          }),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    FutureBuilder(
                        future: getPaymentStatus(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              color: Colors.white12,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Become Premium Member',
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                  FlatButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(18.0),
                                        side:
                                            BorderSide(color: AppColors.white)),
                                    color: Colors.transparent,
                                    textColor: AppColors.white,
                                    padding: EdgeInsets.all(8.0),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                          return PurchaseScreen();
                                        }),
                                      );
                                    },
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
                      title: Text('Home',
                          style: TextStyle(color: AppColors.white)),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Take a tour',
                          style: TextStyle(color: AppColors.white)),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return OnBoardingPage();
                          }),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Sleepfit Coaching Course',
                          style: TextStyle(color: AppColors.white)),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('App info',
                          style: TextStyle(color: AppColors.white)),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return AppInfo();
                          }),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Notifications',
                          style: TextStyle(color: AppColors.white)),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return NotificationScreen();
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Divider(
                    color: AppColors.white,
                    thickness: 1,
                  ),
                  ListTile(
                    title: Text('Settings',
                        style: TextStyle(color: AppColors.white)),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return Settings();
                        }),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Logout',
                        style: TextStyle(color: AppColors.white)),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                      preference.setLoginState(false);
                      preference.sharedPreferencesSet("token", "");
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/root', (Route<dynamic> route) => false);
                    },
                  ),
                ],
              )
            ],
          )),
    );
  }
// </editor-fold>
}
