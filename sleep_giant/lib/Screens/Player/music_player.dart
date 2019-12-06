import 'dart:async';


import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:sleep_giant/API%20Models/all_programs_list_response.dart';

import 'package:sleep_giant/Generic/generic_helper.dart';

import 'package:sleep_giant/Screens/Player/player_widget.dart';

class Player extends StatefulWidget {
  final ProgramtypeData programTypeData;
  final bool isSleepDeck;
  final Programs currentProgram;
  final SleepDecks sleepDecks;

  const Player({
    Key key,
    this.programTypeData,
    this.isSleepDeck,
    this.currentProgram,
    this.sleepDecks,
  }) : super(key: key);
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  String totalDuration = "";
  int total = 0;
  double currentTime;
  double seekBarValue;

  ScrollController _controller = ScrollController();

  int current = 0;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    initPlatformState();
    totalDuration = widget.isSleepDeck
        ? getTotalDuration(widget.sleepDecks.decks)
        : getTotalDuration([widget.currentProgram]);
    super.initState();
  }

  // Initializing the Music Player and adding a single [PlaylistItem]
  Future<void> initPlatformState() async {
    // playMusic();
  }

//  playMusic() {
//    PlayerWidget(
//        url: widget.isSleepDeck ? widget.programTypeData.programs[0].sound.audio:widget.currentProgram.sound.audio,
//        mode: PlayerMode.LOW_LATENCY);
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isSleepDeck
              ? widget.sleepDecks.name
              : widget.currentProgram.name),
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
        decoration: new BoxDecoration(
            image: new DecorationImage(
          image: new AssetImage("assets/theme_bg.png"),
          fit: BoxFit.cover,
        )),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
//                  height: MediaQuery.of(context).size.height / 2.5,
                  child: new Swiper(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return new Image.network(
                        widget.isSleepDeck
                            ? widget
                                .sleepDecks.decks[index].coverImage.thumbnail
                            : widget.currentProgram.coverImage.thumbnail,
                        fit: BoxFit.fill,
                      );
                    },
                    onIndexChanged: (index) {
                      current = index;
                      print('current = $current');
                    },
                    itemCount:
                        widget.isSleepDeck ? widget.sleepDecks.decks.length : 1,
                    viewportFraction: 0.8,
                    scale: 0.9,
                  ),
                ),
                Container(
                  height: 200,
                  color: Colors.transparent,
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      controller: _controller,
                      itemCount: widget.isSleepDeck
                          ? widget.sleepDecks.decks.length
                          : 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.transparent,
                          child: ListTile(
                            isThreeLine: true,
                            leading: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              child: new Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: new BoxDecoration(
                                      //color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(
                                              widget.isSleepDeck
                                                  ? widget
                                                      .sleepDecks
                                                      .decks[index]
                                                      .coverImage
                                                      .thumbnail
                                                  : widget.currentProgram
                                                      .coverImage.thumbnail)))),
                              foregroundColor: Colors.white,
                            ),
                            title: Text(
                              widget.isSleepDeck
                                  ? widget.sleepDecks.decks[index].name
                                  : widget.currentProgram.name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            subtitle: Text(
                              widget.isSleepDeck
                                  ? widget.sleepDecks.decks[index].description
                                  : widget.currentProgram.description,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }),
                ),
                PlayerWidget(
                  url: widget.isSleepDeck
                      ? widget.sleepDecks.decks[0].sound
                      : widget.currentProgram.sound.audio,
                  totalDuration: widget.isSleepDeck
                      ? getTotalDurationForPlayer(widget.sleepDecks.decks)
                      : Duration(seconds: widget.currentProgram.duration),
                ),
              ],
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
      ),
    );
  }

  String getTotalDuration(List<dynamic> programs) {
    for (var program in programs) {
      total = total + program.duration;
    }
    final now = Duration(seconds: total);
    return generic.getDurationFormattedString(now);
  }

//  String getTotalDurationSleepDeck(List<Decks> programs) {
//    for (var program in programs) {
//      total = total + program.duration;
//    }
//    final now = Duration(seconds: total);
//    return generic.printDuration(now);
//  }

  String getCurrentTime(int seconds) {
    final now = Duration(seconds: seconds);
    return generic.getDurationFormattedString(now);
  }

  Duration getTotalDurationForPlayer(List<Decks> programs) {
    for (var program in programs) {
      total = total + program.duration;
    }
    final now = Duration(seconds: total);

    return now;
  }
}
