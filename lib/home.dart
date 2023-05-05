import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_proben/logik/Klassen.dart';
import 'package:flutter_proben/logik/appstate.dart';
import 'package:flutter_proben/logik/physic_frames.dart';
import 'package:flutter_proben/logik/vector2.dart';

// import 'package:audioplayers/audio_cache.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final appstate = Appstate();

  Player player1 = Player(
      size: appstate.playerSize,
      position: Vector2(
          x: appstate.playGroundWidth - appstate.playerSize, y: appstate.playGroundHeight - appstate.playerSize),
      face: appstate.emojies.empty);
  Player player2 = Player(
    size: appstate.playerSize,
    position: Vector2(),
    face: appstate.emojies.empty,
  );
  Ball whiteBall = Ball(
    body: appstate.emojies.empty,
    size: appstate.foodSize,
    position: Vector2(
        x: (appstate.playGroundWidth - appstate.playerSize) / 2,
        y: (appstate.playGroundHeight - appstate.playerSize) / 2),
  );
  Ball blackBall = Ball(
    body: appstate.emojies.empty,
    size: appstate.foodSize,
    position: Vector2(
        x: (appstate.playGroundWidth - appstate.playerSize) / 2,
        y: (appstate.playGroundHeight - appstate.playerSize) / 2),
  );

  Duration lastFrame = Duration.zero;

  void keyCListener(RawKeyEvent event) {
    Vector2 dirPlayer1 = Vector2();
    Vector2 dirPlayer2 = Vector2();
    if (appstate.playingMode) {
//Player1 Movement
      appstate.player1Up(player1, dirPlayer1);
      appstate.player1Down(player1, dirPlayer1);
      appstate.player1Right(player1, dirPlayer1);
      appstate.player1Left(player1, dirPlayer1);

// Player2 Movement
      appstate.player2Up(player2, dirPlayer2);
      appstate.player2Down(player2, dirPlayer2);
      appstate.player2Right(player2, dirPlayer2);
      appstate.player2Left(player2, dirPlayer2);

      player1.moveDirection = dirPlayer1;
      player2.moveDirection = dirPlayer2;
    }
  }

  @override
  void initState() {
    RawKeyboard.instance.addListener(keyCListener);
    PhysicFrames.addListener(player1.move);
    PhysicFrames.addListener(player2.move);
    super.initState();
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(keyCListener);
    PhysicFrames.removeListener(player1.move);
    PhysicFrames.removeListener(player2.move);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    appstate.playGroundHeight = 0.8 * height;
    appstate.playGroundWidth = 0.8 * width;

    if (appstate.playingMode) {
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        final delay = Duration(microseconds: (20000 - (duration - lastFrame).inMicroseconds));
        Future.delayed(
            delay,
            () => setState(() {
                  appstate.playingRools(player1, player2, whiteBall, blackBall);
                  appstate.gameEnds(player1, player2, whiteBall, blackBall);
                }));
        lastFrame = duration;
      });
    }
    TextEditingController controller1 = TextEditingController(text: player1.name);
    TextEditingController controller2 = TextEditingController(text: player2.name);

    return Scaffold(
      floatingActionButton: Container(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    appstate.playBottun(player1, player2, whiteBall, blackBall);
                  });
                  // final spieler = Spieler(name: 'Paul', power: 2);
                  // spielers.add(spieler);
                },
                child: Icon(
                  Icons.play_arrow,
                  size: player1.size * 0.6,
                  color: appstate.playingMode ? Colors.blue : Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    setState(() {
                      appstate.playingMode = false;
                      appstate.stoped = true;
                    });
                  },
                  child: Icon(
                    Icons.pause,
                    size: player1.size * 0.6,
                    color: appstate.stoped ? Colors.red : Colors.grey,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    setState(() {
                      appstate.restart(player1, player2, whiteBall, blackBall);
                    });
                  },
                  child: Icon(
                    Icons.refresh,
                    size: player1.size * 0.6,
                  )),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: player1.name == null || player2.name == null
            ? Column(
                children: [
                  TextFormField(
                    controller: controller1,
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                player1.name = controller1.text;
                                print(player1.name);
                              });
                            },
                            icon: Icon(Icons.edit))),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                setState(() {
                                  player2.name = controller2.text;
                                  print(player2.name);
                                });
                              });
                            },
                            icon: Icon(Icons.edit))),
                    controller: controller2,
                  ),
                ],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(appstate.playGroundWidth / 4, 10, appstate.playGroundWidth / 4, 10),
                        child: Text(
                          '${player2.name ?? 'Player2'} : ${player2.score}',
                          style: const TextStyle(color: Colors.blue, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: appstate.playGroundWidth / 4),
                        child: Text(
                          '${player1.name ?? 'Player1'} : ${player1.score}',
                          style: const TextStyle(color: Colors.red, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                  //playground
                  Container(
                    height: appstate.playGroundHeight,
                    width: appstate.playGroundWidth,
                    decoration: BoxDecoration(color: Color.fromARGB(255, 24, 61, 66)),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            appstate.winner + ' Wins',
                            style: TextStyle(
                                color: appstate.gameOver ? Colors.amber : Color.fromARGB(0, 255, 193, 7),
                                fontSize: appstate.playGroundWidth * 0.1),
                          ),
                        ),
                        //player1
                        Positioned(
                          left: player1.position.x - player1.size * 0.28,
                          top: player1.position.y - player1.size * 0.28,
                          child: Text(
                            player1.face.code,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: player1.size),
                          ),
                        ),
                        //player2
                        Positioned(
                            left: player2.position.x,
                            top: player2.position.y,
                            child: Text(
                              player2.face.code,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: player2.size),
                            )),
                        //White Ball
                        Positioned(
                            left: whiteBall.position.x,
                            top: whiteBall.position.y,
                            child: Text(
                              whiteBall.body.code,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: whiteBall.size,
                              ),
                            )),
                        //Black Ball
                        Positioned(
                            left: blackBall.position.x,
                            top: blackBall.position.y,
                            child: Text(
                              blackBall.body.code,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: whiteBall.size),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
