import 'package:flutter/material.dart';
import 'package:sleep_giant/API%20Models/all_programs_list_response.dart';
import 'package:sleep_giant/Screens/Player/music_player.dart';

class MusicList extends StatelessWidget {
  final ProgramtypeData programTypeData;

  const MusicList({Key key, this.programTypeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = programTypeData.name;

    return Scaffold(
      appBar: AppBar(
          title: Text(title),
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
          ),
        ),
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(programTypeData.programs.length, (index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return Player(
                      programTypeData: programTypeData,
                      isSleepDeck: false,
                      currentProgram: programTypeData.programs[index],
                    );
                  }),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Stack(
                  children: <Widget>[
                    Image.network(
                        programTypeData.programs[index].coverImage.original),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Card(
                        color: Colors.transparent,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              programTypeData.programs[index].name,
                              maxLines: 1,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              programTypeData.programs[index].description,
                              maxLines: 1,
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
