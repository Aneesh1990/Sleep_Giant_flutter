import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sleep_giant/API%20Models/all_programs_list_response.dart';
import 'package:sleep_giant/API%20Models/sleep_deck_model.dart';
import 'package:sleep_giant/API%20Models/sleep_deck_save_model.dart';
import 'package:sleep_giant/API/api_helper.dart';
import 'package:sleep_giant/Generic/generic_helper.dart';
import 'package:sleep_giant/Screens/Player/music_player.dart';
import 'package:sleep_giant/Style/colors.dart';

class SleepDeck extends StatefulWidget {
  final List<ProgramtypeData> programTypeData;
  final List<SleepDecks> sleepDecks;

  const SleepDeck({Key key, this.programTypeData, this.sleepDecks})
      : super(key: key);
  @override
  _SleepDeckState createState() => _SleepDeckState();
}

class _SleepDeckState extends State<SleepDeck> {
  PersistentBottomSheetController _controller;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int sleepDeepRepeat = 0;
  SleepDeckModel sleepDeckModel = SleepDeckModel();
  CrossAxisAlignment cross = CrossAxisAlignment.center;
  MainAxisAlignment main = MainAxisAlignment.center;
  final TextEditingController _emailController = TextEditingController();
  bool showFab = true;
  SleepDeckSaveModel requestModel = SleepDeckSaveModel(deckName: '', decks: []);

  // <editor-fold desc=" Net work - calls  ">
  _onSubmit() async {
    Dialogs.showLoadingDialog(context, _keyLoader);

    requestModel.deckName = _emailController.text ?? "sleep deck";
    await ApiBaseHelper().saveSleepDeck(requestModel).then((response) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      print(response.toString());
      if (response.status == 1) {
        generic.alertDialog(
            context, 'Alert', 'Your Sleep Deck is saved successfully', () {
          setState(() {
            widget.sleepDecks.add(response.sleepDecks);
            _emailController.text = "";
          });

          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return Player(
                programTypeData: ProgramtypeData(),
                isSleepDeck: true,
                currentProgram: Programs(),
                sleepDecks: response.sleepDecks,
              );
            }),
          );
        });
      } else {
        generic.alertDialog(
            scaffoldKey.currentContext, 'Alert', 'something went wrong', () {});
      }
    });
  }

  _deleteDeck(int id) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    await ApiBaseHelper().deleteSleepDeck(id).then((response) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (response.statusCode == 200) {
        setState(() {
          widget.sleepDecks.removeWhere((deck) => deck.id == id);
        });

        generic.alertDialog(context, 'Alert', 'Sleep Deck deleted Successfull',
            () {
          print('event called');
        });
      } else {
        generic.alertDialog(context, 'Alert', 'Something went wrong', () {});
      }
    });
  }

  // </editor-fold>

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.primary_color,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 80,
                child: Image.asset("assets/header.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios, color: AppColors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: cross,
                mainAxisAlignment: main,
                children: <Widget>[
                  Text(
                    'Sleep Time',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    sleepDeckModel.isYourSleepDeckSelected
                        ? getTotalDuration(sleepDeckModel.yourDecks.decks) +
                            ' hours'
                        : getFormattedTime(sleepDeckModel.totalDuration) +
                            ' hours',
                    style: TextStyle(
                        color: AppColors.white, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: main,
                crossAxisAlignment: cross,
                children: <Widget>[
                  Text(
                    'Wake Up Target',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    generic.getWakeUpTargetTime(
                        sleepDeckModel.isYourSleepDeckSelected
                            ? getTotalDurationTopHeader(
                                sleepDeckModel.yourDecks.decks)
                            : sleepDeckModel.totalDuration),
                    style: TextStyle(
                        color: AppColors.white, fontStyle: FontStyle.italic),
                  ),
                ],
              )
            ],
          ),
          Divider(),
          Text(
            'your sleep sequence',
            style: TextStyle(color: AppColors.white),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: sleepDeckModel.isYourSleepDeckSelected
                  ? getSleepSequenceTopSaved(sleepDeckModel.yourDecks)
                  : getSleepSequence(sleepDeckModel),
            ),
          ),
          Divider(),
          Expanded(
            child: widget.programTypeData.isNotEmpty
                ? ListView(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.all(0.0),
                    children: <Widget>[
                      Container(
                        child: windDown(),
                        color: AppColors.primary_color,
                      ),
                      Container(
                        child: sleepDeep(),
                        color: AppColors.primary_color,
                      ),
                      Container(
                        child: napRecovery(),
                        color: AppColors.primary_color,
                      ),
                      Container(
                        child: wakeUp(),
                        color: AppColors.primary_color,
                      ),
                      Container(
                        child: sleepDeck(),
                        color: AppColors.primary_color,
                      ),
                    ],
                  )
                : Container(),
          ),
          Container(
            height: 80,
            color: Colors.indigo,
            child: Stack(
              children: <Widget>[
                Center(
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.transparent)),
                    onPressed: () async {
                      print("audio clicked");

                      if (sleepDeckModel.isWindDownSelected ||
                          sleepDeckModel.isSleepDeepSelected ||
                          sleepDeckModel.isNapRecoverySelected ||
                          sleepDeckModel.isWakeUpSelected ||
                          sleepDeckModel.isYourSleepDeckSelected) {
                      } else {
                        generic.alertDialog(context, "Alert",
                            "Please choose atleast 1 program", () {});
                        return;
                      }

                      if (sleepDeckModel.isYourSleepDeckSelected) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return Player(
                              programTypeData: ProgramtypeData(),
                              isSleepDeck: true,
                              currentProgram: Programs(),
                              sleepDecks: sleepDeckModel.yourDecks,
                            );
                          }),
                        );
                        return;
                      }

                      List<int> audios = [];
                      List<Decks> decks = [];
                      CoverImage coverImage;
                      String programTypeId;
                      String sound;
                      int themeId;
                      int duration;
                      if (sleepDeckModel.isWindDownSelected) {
                        audios.add(sleepDeckModel.windDownProgram.id);
                        decks.add(Decks(
                          id: sleepDeckModel.windDownProgram.id,
                          name: sleepDeckModel.wakeUpProgram.name,
                          description: sleepDeckModel.wakeUpProgram.description,
                          coverImage: sleepDeckModel.wakeUpProgram.coverImage,
                          programTypeId:
                              sleepDeckModel.wakeUpProgram.programTypeId,
                          sound: sleepDeckModel.wakeUpProgram.sound.audio,
                          themeId: sleepDeckModel.wakeUpProgram.themeId,
                          duration: sleepDeckModel.wakeUpProgram.duration,
                        ));
                      }
                      if (sleepDeckModel.isSleepDeepSelected) {
                        for (var i = 0;
                            i < sleepDeckModel.sleepDeepCount;
                            i++) {
                          audios.add(sleepDeckModel.sleepDeepProgram.id);
                          decks.add(Decks(
                            id: sleepDeckModel.sleepDeepProgram.id,
                            name: sleepDeckModel.sleepDeepProgram.name,
                            description:
                                sleepDeckModel.sleepDeepProgram.description,
                            coverImage:
                                sleepDeckModel.sleepDeepProgram.coverImage,
                            programTypeId:
                                sleepDeckModel.sleepDeepProgram.programTypeId,
                            sound: sleepDeckModel.sleepDeepProgram.sound.audio,
                            themeId: sleepDeckModel.sleepDeepProgram.themeId,
                            duration: sleepDeckModel.sleepDeepProgram.duration,
                          ));
                        }
                      }
                      if (sleepDeckModel.isNapRecoverySelected) {
                        audios.add(sleepDeckModel.napRecoveryProgram.id);
                        decks.add(Decks(
                          id: sleepDeckModel.napRecoveryProgram.id,
                          name: sleepDeckModel.napRecoveryProgram.name,
                          description:
                              sleepDeckModel.napRecoveryProgram.description,
                          coverImage:
                              sleepDeckModel.napRecoveryProgram.coverImage,
                          programTypeId:
                              sleepDeckModel.napRecoveryProgram.programTypeId,
                          sound: sleepDeckModel.napRecoveryProgram.sound.audio,
                          themeId: sleepDeckModel.napRecoveryProgram.themeId,
                          duration: sleepDeckModel.napRecoveryProgram.duration,
                        ));
                      }

                      if (sleepDeckModel.isWakeUpSelected) {
                        audios.add(sleepDeckModel.wakeUpProgram.id);
                        decks.add(Decks(
                          id: sleepDeckModel.wakeUpProgram.id,
                          name: sleepDeckModel.wakeUpProgram.name,
                          description: sleepDeckModel.wakeUpProgram.description,
                          coverImage: sleepDeckModel.wakeUpProgram.coverImage,
                          programTypeId:
                              sleepDeckModel.wakeUpProgram.programTypeId,
                          sound: sleepDeckModel.wakeUpProgram.sound.audio,
                          themeId: sleepDeckModel.wakeUpProgram.themeId,
                          duration: sleepDeckModel.wakeUpProgram.duration,
                        ));
                      }

                      requestModel.decks = [
                        SaveDecks(name: "", programIds: audios)
                      ];

                      sleepDeckModel.yourDecks =
                          SleepDecks(name: "", decks: decks);

                      print("requestModel ==== $requestModel");
                      showDeckSaveSheet();
                    },
                    color: AppColors.your_sleep_deck_color_button,
                    textColor: AppColors.white,
                    child: Text("Load your Sleep Deck",
                        style: TextStyle(fontSize: 14)),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      child: Image.asset("assets/torch.png"),
                      onTap: () {},
                    ))
              ],
            ),
          )
        ],
      ),
    ));
  }

  // <editor-fold desc=" Creating Expansion tiles">
  ConfigurableExpansionTile sleepDeck() {
    return ConfigurableExpansionTile(
      headerExpanded: tileHeader(HeaderModel([
        AppColors.your_sleep_deck,
        AppColors.your_sleep_deck_dark,
      ], "Your Sleep Decks", "assets/upArrow.png")),
      header: tileHeader(
        HeaderModel([
          AppColors.your_sleep_deck,
          AppColors.your_sleep_deck_dark,
        ], "Your Sleep Decks", "assets/downArrow.png"),
      ),
      children: getSleepSequenceSaved(widget.sleepDecks),
    );
  }

  ConfigurableExpansionTile wakeUp() {
    return ConfigurableExpansionTile(
      headerExpanded: tileHeader(
        HeaderModel([
          AppColors.wake_up_color,
          AppColors.wake_up_color_dark,
        ], "Wake Up", "assets/upArrow.png"),
      ),
      //animatedWidgetFollowingHeader: Image.asset('assets/upArrow.png'),
      header: tileHeader(HeaderModel([
        AppColors.wake_up_color,
        AppColors.wake_up_color_dark,
      ], "Wake Up", "assets/downArrow.png")),

      children: getWakeUpWidgets(widget.programTypeData[3].programs),
    );
  }

  ConfigurableExpansionTile napRecovery() {
    return ConfigurableExpansionTile(
      headerExpanded: tileHeader(
        HeaderModel([
          AppColors.nap_recovery_colors,
          AppColors.nap_recovery_color,
        ], "Nap Recovery", "assets/upArrow.png"),
      ),
      //animatedWidgetFollowingHeader: Image.asset('assets/upArrow.png'),
      header: tileHeader(HeaderModel([
        AppColors.nap_recovery_colors,
        AppColors.nap_recovery_color,
      ], "Nap Recovery", "assets/downArrow.png")),

      children: getNapRecoveryWidgets(widget.programTypeData[2].programs),
    );
  }

  ConfigurableExpansionTile sleepDeep() {
    return ConfigurableExpansionTile(
      headerExpanded: tileHeader(
        HeaderModel([
          AppColors.sleep_deep_color_dark,
          AppColors.sleep_deep_color,
        ], "Sleep Deep", "assets/upArrow.png"),
      ),
      //animatedWidgetFollowingHeader: Image.asset('assets/upArrow.png'),
      header: tileHeader(HeaderModel([
        AppColors.sleep_deep_color_dark,
        AppColors.sleep_deep_color,
      ], "Sleep Deep", "assets/downArrow.png")),
      children: getSleepDeepWidgets(widget.programTypeData[1].programs),
    );
  }

  ConfigurableExpansionTile windDown() {
    return ConfigurableExpansionTile(
      headerExpanded: tileHeader(
        HeaderModel([
          Colors.green,
          AppColors.wind_down_color_dark,
        ], "Wind Down", "assets/upArrow.png"),
      ),
      //animatedWidgetFollowingHeader: Image.asset('assets/upArrow.png'),
      header: tileHeader(HeaderModel([
        Colors.green,
        AppColors.wind_down_color_dark,
      ], "Wind Down", "assets/downArrow.png")),
      children: getWindDownWidgets(widget.programTypeData[0].programs),
    );
  }
  // </editor-fold>

  // <editor-fold desc=" Create wind down list and selection handler ">
  List<Widget> getWindDownWidgets(List<Programs> programs) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < programs.length; i++) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Container(
          height: AppSize.itemSize,
          color: AppColors.wind_down_color,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              InkWell(
                child: new Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        border:
                            sleepDeckModel.selectedWindDown != programs[i].id
                                ? Border.all(color: Colors.transparent)
                                : Border.all(color: Colors.green, width: 3),
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                programs[i].coverImage.thumbnail)))),
                onTap: () {
                  _showDetailScreen(programs[i], 'Wind Down', [
                    Colors.green,
                    AppColors.wind_down_color_dark,
                  ]);
                },
              ),
              IconButton(
                icon: Icon(
                  sleepDeckModel.selectedWindDown != programs[i].id
                      ? Icons.check_box_outline_blank
                      : Icons.check_box,
                  color: AppColors.white,
                ),
                onPressed: () {
                  setState(() {
                    windDownEventHandle(programs, i);
                  });
                },
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      programs[i].name,
                      style: TextStyle(color: AppColors.white),
                    ),
                    Text(
                      "Duration: " + getFormattedTime(programs[i].duration),
                      style: TextStyle(color: AppColors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    }
    return list;
  }

  void windDownEventHandle(List<Programs> programs, int i) {
    if (sleepDeckModel.selectedWindDown == programs[i].id) {
      sleepDeckModel.totalDuration =
          sleepDeckModel.totalDuration - programs[i].duration;
      sleepDeckModel.selectedWindDown = 0;
      sleepDeckModel.isWindDownSelected = false;
      sleepDeckModel.windDownCount = 0;
      sleepDeckModel.windDownAudio = "";
      sleepDeckModel.windDownProgram = Programs();
    } else {
      sleepDeckModel.isYourSleepDeckSelected = false;
      sleepDeckModel.selectedYourSleepDeck = 0;
      sleepDeckModel.totalDuration = sleepDeckModel.isWindDownSelected
          ? programs[i].duration
          : sleepDeckModel.totalDuration + programs[i].duration;
      sleepDeckModel.selectedWindDown = programs[i].id;
      sleepDeckModel.isWindDownSelected = true;
      sleepDeckModel.windDownCount = 1;
      sleepDeckModel.windDownAudio = programs[i].sound.audio;
      sleepDeckModel.windDownProgram = programs[i];
    }
  }
  // </editor-fold>

  // <editor-fold desc=" Create Sleep Deep list and selection handler ">
  List<Widget> getSleepDeepWidgets(List<Programs> programs) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < programs.length; i++) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Container(
          height: AppSize.itemSize,
          color: AppColors.sleep_deep_color,
          child: Stack(
            children: <Widget>[
              Center(
                  child: Image.asset(
                'assets/sleep_deep_bg.png',
                scale: 1.1,
              )),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      _showDetailScreen(programs[i], 'Sleep Deep', [
                        AppColors.sleep_deep_color_dark,
                        AppColors.sleep_deep_color,
                      ]);
                    },
                    child: new Container(
                        width: 75.0,
                        height: 75.0,
                        decoration: new BoxDecoration(
                            border: sleepDeckModel.selectedSleepDeep !=
                                    programs[i].id
                                ? Border.all(color: Colors.transparent)
                                : Border.all(color: Colors.green, width: 3),
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    programs[i].coverImage.thumbnail)))),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 120,
                        child: Text(
                          programs[i].name,
                          style: TextStyle(color: AppColors.white),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: cross,
                        mainAxisAlignment: main,
                        children: <Widget>[
                          Image.asset('assets/Polygon_left.png'),
                          InkWell(
                            child: Image.asset('assets/minus.png'),
                            onTap: () {
                              print('-');
                              setState(() {
                                sleepDeckModel.sleepDeepCount =
                                    sleepDeckModel.sleepDeepCount - 1 <= 0
                                        ? 0
                                        : sleepDeckModel.sleepDeepCount - 1;
                                print(sleepDeckModel.sleepDeepCount);
                                if (sleepDeckModel.sleepDeepCount == 0) {
                                  if (sleepDeckModel.isSleepDeepSelected) {
                                    sleepDeckModel.totalDuration =
                                        sleepDeckModel.totalDuration -
                                            programs[i].duration;
                                  }
                                  sleepDeckModel.selectedSleepDeep = 0;
                                  sleepDeckModel.isSleepDeepSelected = false;
                                  sleepDeckModel.sleepDeepAudio = "";
                                  sleepDeckModel.sleepDeepProgram = Programs();
                                } else {
                                  if (sleepDeckModel.isSleepDeepSelected) {
                                    sleepDeckModel.totalDuration =
                                        sleepDeckModel.totalDuration -
                                            programs[i].duration;
                                  }
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Image.asset('assets/plus.png'),
                            onTap: () {
                              setState(() {
                                sleepDeepEventHandle(programs, i);
                              });
                            },
                          ),
                          Image.asset('assets/Polygon_right.png'),
                        ],
                      )
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      new Container(
                          width: 75.0,
                          height: 75.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      programs[i].coverImage.thumbnail)))),
                      Align(
                        child: Text(
                          sleepDeckModel.selectedSleepDeep != programs[i].id
                              ? "0"
                              : sleepDeckModel.sleepDeepCount.toString(),
                          style:
                              TextStyle(color: AppColors.white, fontSize: 30),
                        ),
                        alignment: Alignment.center,
                      )
                    ],
                  )
                ],
              ),
              sleepDeckModel.selectedSleepDeep != programs[i].id &&
                      sleepDeckModel.selectedSleepDeep != 0
                  ? Container(
                      color: Colors.white30,
                    )
                  : Container()
            ],
          ),
        ),
      ));
    }
    return list;
  }

  void sleepDeepEventHandle(List<Programs> programs, int i) {
    sleepDeckModel.isYourSleepDeckSelected = false;
    sleepDeckModel.selectedYourSleepDeck = 0;
    print(sleepDeckModel.windDownCount +
        sleepDeckModel.napRecoveryCount +
        sleepDeckModel.wakeUpCount +
        sleepDeckModel.sleepDeepCount);
    if ((sleepDeckModel.windDownCount +
            sleepDeckModel.napRecoveryCount +
            sleepDeckModel.wakeUpCount +
            sleepDeckModel.sleepDeepCount) ==
        9) return;

    sleepDeckModel.totalDuration =
        sleepDeckModel.totalDuration + programs[i].duration;
    sleepDeckModel.selectedSleepDeep = programs[i].id;
    sleepDeckModel.isSleepDeepSelected = true;
    sleepDeckModel.sleepDeepProgram = programs[i];
    sleepDeckModel.sleepDeepAudio = programs[i].sound.audio;
    if ((sleepDeckModel.windDownCount +
            sleepDeckModel.napRecoveryCount +
            sleepDeckModel.wakeUpCount +
            sleepDeckModel.sleepDeepCount) <
        9) {
      sleepDeckModel.sleepDeepCount = (sleepDeckModel.windDownCount +
                  sleepDeckModel.napRecoveryCount +
                  sleepDeckModel.wakeUpCount +
                  sleepDeckModel.sleepDeepCount) ==
              9
          ? sleepDeckModel.sleepDeepCount
          : sleepDeckModel.sleepDeepCount + 1;
    }
    print('sleepCount');
    print(sleepDeckModel.sleepDeepCount);
  }

  // </editor-fold>

  // <editor-fold desc=" Create Nap Recovery list and selection handler ">
  List<Widget> getNapRecoveryWidgets(List<Programs> programs) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < programs.length; i++) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Container(
          height: AppSize.itemSize,
          color: AppColors.nap_recovery_color,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  _showDetailScreen(programs[i], 'Nap Recovery', [
                    AppColors.nap_recovery_colors,
                    AppColors.nap_recovery_color,
                  ]);
                },
                child: new Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        border:
                            sleepDeckModel.selectedNapRecovery != programs[i].id
                                ? Border.all(color: Colors.transparent)
                                : Border.all(color: Colors.green, width: 3),
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                programs[i].coverImage.thumbnail)))),
              ),
              IconButton(
                icon: Icon(
                  sleepDeckModel.selectedNapRecovery != programs[i].id
                      ? Icons.check_box_outline_blank
                      : Icons.check_box,
                  color: AppColors.white,
                ),
                onPressed: () {
                  setState(() {
                    napRecoveryEventHandle(programs, i);
                  });
                },
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      programs[i].name,
                      style: TextStyle(color: AppColors.white),
                    ),
                    Text(
                      "Duration: " + getFormattedTime(programs[i].duration),
                      style: TextStyle(color: AppColors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    }
    return list;
  }

  void napRecoveryEventHandle(List<Programs> programs, int i) {
    if (sleepDeckModel.selectedNapRecovery == programs[i].id) {
      sleepDeckModel.totalDuration =
          sleepDeckModel.totalDuration - programs[i].duration;
      sleepDeckModel.selectedNapRecovery = 0;
      sleepDeckModel.isNapRecoverySelected = false;
      sleepDeckModel.napRecoveryCount = 0;
      sleepDeckModel.napRecoveryAudio = "";
      sleepDeckModel.napRecoveryProgram = Programs();
    } else {
      sleepDeckModel.isYourSleepDeckSelected = false;
      sleepDeckModel.selectedYourSleepDeck = 0;
      sleepDeckModel.totalDuration = sleepDeckModel.isNapRecoverySelected
          ? programs[i].duration
          : sleepDeckModel.totalDuration + programs[i].duration;
      sleepDeckModel.selectedNapRecovery = programs[i].id;
      sleepDeckModel.isNapRecoverySelected = true;
      sleepDeckModel.napRecoveryCount = 1;
      sleepDeckModel.napRecoveryAudio = programs[i].sound.audio;
      sleepDeckModel.napRecoveryProgram = programs[i];
    }
  }

  // </editor-fold>

  // <editor-fold desc=" Create Wake Up list and selection handler ">

  List<Widget> getWakeUpWidgets(List<Programs> programs) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < programs.length; i++) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Container(
          height: AppSize.itemSize,
          color: AppColors.nap_recovery_color,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () {
                    _showDetailScreen(programs[i], 'Wake Up', [
                      AppColors.wake_up_color_dark,
                      AppColors.wake_up_color,
                    ]);
                  },
                  child: new Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          border:
                              sleepDeckModel.selectedWakeUp != programs[i].id
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.green, width: 3),
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                  programs[i].coverImage.thumbnail))))),
              IconButton(
                icon: Icon(
                  sleepDeckModel.selectedWakeUp != programs[i].id
                      ? Icons.check_box_outline_blank
                      : Icons.check_box,
                  color: AppColors.white,
                ),
                onPressed: () {
                  setState(() {
                    wakeUpEventHandle(programs, i);
                  });
                },
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      programs[i].name,
                      style: TextStyle(color: AppColors.white),
                    ),
                    Text(
                      "Duration: " + getFormattedTime(programs[i].duration),
                      style: TextStyle(color: AppColors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    }
    return list;
  }

  void wakeUpEventHandle(List<Programs> programs, int i) {
    if (sleepDeckModel.selectedWakeUp == programs[i].id) {
      sleepDeckModel.totalDuration =
          sleepDeckModel.totalDuration - programs[i].duration;
      sleepDeckModel.selectedWakeUp = 0;
      sleepDeckModel.isWakeUpSelected = false;
      sleepDeckModel.wakeUpCount = 0;
      sleepDeckModel.wakeUpAudio = "";
      sleepDeckModel.wakeUpProgram = Programs();
    } else {
      sleepDeckModel.isYourSleepDeckSelected = false;
      sleepDeckModel.selectedYourSleepDeck = 0;
      sleepDeckModel.totalDuration = sleepDeckModel.isWakeUpSelected
          ? sleepDeckModel.totalDuration
          : sleepDeckModel.totalDuration + programs[i].duration;
      sleepDeckModel.selectedWakeUp = programs[i].id;
      sleepDeckModel.isWakeUpSelected = true;
      sleepDeckModel.wakeUpCount = 1;
      sleepDeckModel.wakeUpAudio = programs[i].sound.audio;
      sleepDeckModel.wakeUpProgram = programs[i];
    }
  }

  // </editor-fold>

  List<Widget> getSleepDeckWidgets(List<Decks> programs) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < programs.length; i++) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Container(
          height: AppSize.itemSize,
          color: AppColors.nap_recovery_color,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              new Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                      border: sleepDeckModel.selectedWakeUp != programs[i].id
                          ? Border.all(color: Colors.transparent)
                          : Border.all(color: Colors.green, width: 3),
                      shape: BoxShape.rectangle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              programs[i].coverImage.thumbnail)))),
              IconButton(
                icon: Icon(
                  sleepDeckModel.selectedWakeUp != programs[i].id
                      ? Icons.check_box_outline_blank
                      : Icons.check_box,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if (sleepDeckModel.selectedWakeUp == programs[i].id) {
                      sleepDeckModel.totalDuration =
                          sleepDeckModel.totalDuration - programs[i].duration;
                      sleepDeckModel.selectedWakeUp = 0;
                      sleepDeckModel.isWakeUpSelected = false;
                      sleepDeckModel.wakeUpCount = 0;
                      sleepDeckModel.wakeUpAudio = "";
                    } else {
                      sleepDeckModel.isYourSleepDeckSelected = false;
                      sleepDeckModel.selectedYourSleepDeck = 0;
                      sleepDeckModel.totalDuration = sleepDeckModel
                              .isWakeUpSelected
                          ? sleepDeckModel.totalDuration
                          : sleepDeckModel.totalDuration + programs[i].duration;
                      sleepDeckModel.selectedWakeUp = programs[i].id;
                      sleepDeckModel.isWakeUpSelected = true;
                      sleepDeckModel.wakeUpCount = 1;
//                      sleepDeckModel.wakeUpAudio = programs[i].sound;
                    }
                  });
                },
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      programs[i].name,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Duration: " + getFormattedTime(programs[i].duration),
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    }
    return list;
  }

  // <editor-fold desc=" Progress bar widget for saved / sleep deck ">
  List<Widget> getSleepSequenceSaved(List<SleepDecks> programs) {
    int deckTotalDuration = 0;

    List<Widget> list = new List<Widget>();
    for (var deck in programs) {
      for (var i = 0; i < deck.decks.length; i++) {
        //  deckTotalDuration = deckTotalDuration + deck.decks[i].duration;
      }

      List<Widget> listProgress = new List<Widget>();
      List<Color> colorArray = new List<Color>();

      var windDownCount = deck.decks.where((program) {
        return program.themeId == 1;
      });
      var sleepDeepCount = deck.decks.where((program) {
        return program.themeId == 2;
      });
      var wakeUpCount = deck.decks.where((program) {
        return program.themeId == 3;
      });
      var napCount = deck.decks.where((program) {
        return program.themeId == 4;
      });
      if (windDownCount.length > 0) {
        colorArray.add(AppColors.wind_down_color);
      }
      if (sleepDeepCount.length > 0) {
        for (var i = 0; i < sleepDeepCount.length; i++) {
          colorArray.add(AppColors.sleep_deep_color);
        }
      }
      if (napCount.length > 0) {
        colorArray.add(AppColors.nap_recovery_color);
      }
      if (wakeUpCount.length > 0) {
        colorArray.add(AppColors.wake_up_color);
      }

      int rest = 9 - colorArray.length;
      for (var i = 0; i < rest; i++) {
        colorArray.add(Colors.transparent);
      }
      for (var i = 0; i < 9; i++) {
        listProgress.add(Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/Rectangle.png"),
                fit: BoxFit.fitHeight,
              ),
              color: colorArray[i]),
          width: 30,
          height: 40,
        ));
      }

      listProgress.add(SizedBox(
        width: 10,
      ));

      /////////
      listProgress.add(IconButton(
        icon: Icon(
          sleepDeckModel.selectedYourSleepDeck != deck.id
              ? Icons.check_box_outline_blank
              : Icons.check_box,
          color: Colors.white,
        ),
        onPressed: () {
          print('show fab = $showFab');
          showFab
              ? setState(() {
                  sleepDeckState(deck, deckTotalDuration);
                })
              : _controller.setState(() {
                  sleepDeckState(deck, deckTotalDuration);
                });
        },
      ));
      /////////

      list.add(Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
        child: Container(
          height: AppSize.itemSize + 45,
          color: AppColors.your_sleep_deck,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sleep Deck : ',
                      style: TextStyle(color: Colors.white),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(deck.name,
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          sleepDeckState(deck, deckTotalDuration);
                        });
                        _showDetailScreenSleepDeck(deck.name, [
                          AppColors.your_sleep_deck,
                          AppColors.your_sleep_deck_dark,
                        ]);
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        askPermissionForDeleteDeck(
                            scaffoldKey.currentContext, deck.id);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Sleep Time :' + getTotalDuration(deck.decks),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: listProgress,
              )
            ],
          ),
        ),
      ));
    }

    return list;
  }
  // </editor-fold>

  // <editor-fold desc=" sleep deck state change handle">
  void sleepDeckState(SleepDecks deck, int deckTotalDuration) {
    if (sleepDeckModel.selectedYourSleepDeck == deck.id) {
      sleepDeckModel.totalDuration = 0;
      sleepDeckModel.selectedYourSleepDeck = 0;
      sleepDeckModel.isYourSleepDeckSelected = false;
      sleepDeckModel.yourDecks = SleepDecks();
    } else {
      sleepDeckModel.isWindDownSelected = false;
      sleepDeckModel.selectedWindDown = 0;
      sleepDeckModel.isSleepDeepSelected = false;
      sleepDeckModel.selectedSleepDeep = 0;
      sleepDeckModel.isNapRecoverySelected = false;
      sleepDeckModel.selectedNapRecovery = 0;
      sleepDeckModel.isWakeUpSelected = false;
      sleepDeckModel.selectedNapRecovery = 0;
      sleepDeckModel.totalDuration = deckTotalDuration;
      sleepDeckModel.selectedYourSleepDeck = deck.id;
      sleepDeckModel.isYourSleepDeckSelected = true;
      sleepDeckModel.yourDecks = deck;
    }
  }
  // </editor-fold">

  // <editor-fold desc=" Progress bar widget if it is sleep deck already saved ">
  List<Widget> getSleepSequenceTopSaved(SleepDecks programs) {
    List<Widget> list = new List<Widget>();
    List<Color> colorArray = new List<Color>();

    var windDownCount = programs.decks.where((program) {
      return program.themeId == 1;
    });
    var sleepDeepCount = programs.decks.where((program) {
      return program.themeId == 2;
    });
    var wakeUpCount = programs.decks.where((program) {
      return program.themeId == 3;
    });
    var napCount = programs.decks.where((program) {
      return program.themeId == 4;
    });
    if (windDownCount.length > 0) {
      colorArray.add(AppColors.wind_down_color);
    }
    if (sleepDeepCount.length > 0) {
      for (var i = 0; i < sleepDeepCount.length; i++) {
        colorArray.add(AppColors.sleep_deep_color);
      }
    }
    if (napCount.length > 0) {
      colorArray.add(AppColors.nap_recovery_color);
    }
    if (wakeUpCount.length > 0) {
      colorArray.add(AppColors.wake_up_color);
    }

    int rest = 9 - colorArray.length;
    for (var i = 0; i < rest; i++) {
      colorArray.add(Colors.transparent);
    }
    for (var i = 0; i < 9; i++) {
      list.add(Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/Rectangle.png"),
              fit: BoxFit.fitHeight,
            ),
            color: colorArray[i]),
        width: 30,
        height: 40,
      ));
    }

    return list;
  }
  // </editor-fold>

  // <editor-fold desc=" Progress bar widget">
  List<Widget> getSleepSequence(SleepDeckModel sleepDeckModel) {
    List<Color> colorArray = new List<Color>();
    if (sleepDeckModel.isWindDownSelected) {
      colorArray.add(AppColors.wind_down_color);
    }
    if (sleepDeckModel.isSleepDeepSelected) {
      for (var i = 0; i < sleepDeckModel.sleepDeepCount; i++) {
        colorArray.add(AppColors.sleep_deep_color);
      }
    }
    if (sleepDeckModel.isNapRecoverySelected) {
      colorArray.add(AppColors.nap_recovery_color);
    }
    if (sleepDeckModel.isWakeUpSelected) {
      colorArray.add(AppColors.wake_up_color);
    }

    int rest = 9 - colorArray.length;

    for (var i = 0; i < rest; i++) {
      colorArray.add(Colors.transparent);
    }

    List<Widget> list = new List<Widget>();
    for (var i = 0; i < 9; i++) {
      list.add(Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/Rectangle.png"),
                  fit: BoxFit.fitHeight,
                ),
                color: colorArray[i]),
            width: 30,
            height: 40,
          ),
        ],
      ));
    }
    return list;
  }
  // </editor-fold>

  // <editor-fold desc=" get formatted time in string  ">
  String getFormattedTime(int totalSeconds) {
    if (totalSeconds < 0) {
      return "00:00:00";
    }

    int remainingHours = (totalSeconds / 3600).floor();
    int remainingMinutes = (totalSeconds / 60).floor() - remainingHours * 60;
    int remainingSeconds =
        totalSeconds - remainingMinutes * 60 - remainingHours * 3600;

    return remainingHours.toString().padLeft(2, '0') +
        ":" +
        remainingMinutes.toString().padLeft(2, '0') +
        ":" +
        remainingSeconds.toString().padLeft(2, '0');
  }
  // </editor-fold>

  // <editor-fold desc=" Return Gradient header and title of the list of wind down, nap recovery , wake up, sleep deep and sleep deck">
  Widget tileHeader(HeaderModel headerModel) {
    return Flexible(
      child: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: headerModel.headerGradientColor,
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          height: AppSize.headerSize,
          child: Row(
            crossAxisAlignment: cross,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  headerModel.title,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(headerModel.imageName),
              SizedBox(
                width: 40,
              ),
            ],
          )),
    );
  }
  // </editor-fold>

  // <editor-fold desc=" get sleep deck configure total duration in specified format in string ">
  String getTotalDuration(List<Decks> programs) {
    int total = 0;
    for (var program in programs) {
      total = total + program.duration;
    }
    final now = Duration(seconds: total);
    // print("${_printDuration(now)}");

    return generic.getDurationFormattedString(now);
  }
  // </editor-fold>

  // <editor-fold desc=" get sleep deck configure total duration in INT format ">

  int getTotalDurationTopHeader(List<Decks> programs) {
    int total = 0;
    for (var program in programs) {
      print('program id =  ' + program.name);
      total = total + program.duration;
    }

    return total;
  }

  // </editor-fold">

  // <editor-fold desc=" Show detail screen for wind down, nap recovery and wake up">
  _showDetailScreen(Programs programs, String name, List<Color> colors) {
    scaffoldKey.currentState.showBottomSheet((context) => Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(20.0)),
              gradient: new LinearGradient(
                  colors: colors,
                  begin: const FractionalOffset(0.1, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Image.network(programs.coverImage.original),
                    ),
                    Text(
                      name,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Text(
                      'Duration : ' +
                          getFormattedTime(programs.duration) +
                          ' minutes',
                      style: TextStyle(color: Colors.white),
                    ),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          programs.description,
                          style: TextStyle(color: Colors.white),
                        )),
                    RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      onPressed: () {
                        setState(() {
                          if (name == 'Wind Down') {
                            windDownEventHandle([programs], 0);
                          } else if (name == 'Sleep Deep') {
                            sleepDeepEventHandle([programs], 0);
                          } else if (name == 'Nap Recovery') {
                            napRecoveryEventHandle([programs], 0);
                          } else if (name == 'Wake Up') {
                            wakeUpEventHandle([programs], 0);
                          }
                        });
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                      textColor: Colors.black,
                      child: Text("Add to sleep Deck",
                          style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
  // </editor-fold">

  // <editor-fold desc=" Show detail screen of the sleep deck">

  void _showDetailScreenSleepDeck(String name, List<Color> colors) async {
    _controller = await scaffoldKey.currentState.showBottomSheet((context) =>
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(20.0)),
              gradient: new LinearGradient(
                  colors: colors,
                  begin: const FractionalOffset(0.1, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: cross,
                          mainAxisAlignment: main,
                          children: <Widget>[
                            Text(
                              'Sleep Time',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              sleepDeckModel.isYourSleepDeckSelected
                                  ? getTotalDuration(
                                          sleepDeckModel.yourDecks.decks) +
                                      ' hours'
                                  : getFormattedTime(
                                          sleepDeckModel.totalDuration) +
                                      ' hours',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Text(
                      'your sleep sequence',
                      style: TextStyle(color: Colors.white),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: sleepDeckModel.isYourSleepDeckSelected
                            ? getSleepSequenceTopSaved(sleepDeckModel.yourDecks)
                            : getSleepSequence(sleepDeckModel),
                      ),
                    ),
                    Divider(),
                    Expanded(
                      child: widget.programTypeData.isNotEmpty
                          ? ListView(
                              physics: ClampingScrollPhysics(),
                              padding: EdgeInsets.all(0.0),
                              children: <Widget>[
                                Container(
                                  child: windDown(),
                                  color: AppColors.primary_color,
                                ),
                                Container(
                                  child: sleepDeep(),
                                  color: AppColors.primary_color,
                                ),
                                Container(
                                  child: napRecovery(),
                                  color: AppColors.primary_color,
                                ),
                                Container(
                                  child: wakeUp(),
                                  color: AppColors.primary_color,
                                ),
                                Container(
                                  child: sleepDeck(),
                                  color: AppColors.primary_color,
                                ),
                              ],
                            )
                          : Container(),
                    ),
                    Container(
                      height: 80,
                      color: Colors.indigo,
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.transparent)),
                              onPressed: () {
                                setState(() {});
                                Navigator.pop(context);
                              },
                              color: Colors.white,
                              textColor: Colors.black,
                              child: Text("Add to sleep Deck",
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
    changeBottomSheetState(false);

    _controller.closed.then((value) {
      changeBottomSheetState(true);
    });
  }
  // </editor-fold">

  // <editor-fold desc=" Show a sheet for saving the created deck with a name or launcnh without saving">
  void showDeckSaveSheet() {
    scaffoldKey.currentState.showBottomSheet((context) => Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [Color(0xFFCD35F5), Color(0xFF2F1D73)],
                begin: const FractionalOffset(0.1, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 56,
                        ),
                        Text(
                          'Do you want to save this Sleep Deck?',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Name : ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(
                              height: 40,
                              width: 200,
                              child: Container(
                                color: Colors.white,
                                child: TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: '',
                                    labelStyle: TextStyle(color: Colors.black),
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
                                  autovalidate: false,
                                  autocorrect: false,
                                ),
                              ),
                            ), //downloadFile
                            //                                TextFormField(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.indeterminate_check_box),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                            Text(
                              'Do not disturb - check phone settings',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.transparent)),
                              onPressed: () {
                                if (_emailController.text.isEmpty) {
                                  generic.alertDialog(
                                      context,
                                      "Alert",
                                      "Please enter a name for proceeding",
                                      () {});
                                  return;
                                }
                                Navigator.pop(context);
                                _onSubmit();
                              },
                              color: AppColors.your_sleep_deck_color_button,
                              textColor: Colors.white,
                              child:
                                  Text("Save", style: TextStyle(fontSize: 14)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.transparent)),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return Player(
                                      programTypeData: ProgramtypeData(),
                                      isSleepDeck: true,
                                      currentProgram: Programs(),
                                      sleepDecks: sleepDeckModel.yourDecks,
                                    );
                                  }),
                                );
                              },
                              color: AppColors.your_sleep_deck_color_button,
                              textColor: Colors.white,
                              child: Text("Launch without saving",
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ],
                        )
                      ]),
                ],
              )),
        ));
  }
  // </editor-fold>

  // <editor-fold desc="Ask permission for delete a specified Deck in showModalBottomSheet ">
  void askPermissionForDeleteDeck(context, int id) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Colors.white,
            child: new Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Are you sure do you want to delete the deck ?',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                new ListTile(
                    leading: new Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    title: new Text('yes'),
                    onTap: () {
                      Navigator.pop(context);
                      _deleteDeck(id);
                    }),
                new ListTile(
                  leading: new Icon(
                    Icons.close,
                    color: Colors.redAccent,
                  ),
                  title: new Text('no'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
  // </editor-fold>

  // <editor-fold desc="Change the status of the bottom sheet because the bottom sheet won't update when setstate call">
  void changeBottomSheetState(bool value) {
    setState(() {
      showFab = value;
    });
  }
// </editor-fold>

}

// <editor-fold desc=" Dialogs For application indicator showing while app connecting to the network ">
class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
// </editor-fold>
