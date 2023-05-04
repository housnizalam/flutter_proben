import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_proben/Klassen.dart';
import 'package:flutter_proben/appstate.dart';
import 'package:flutter_proben/emojis.dart';
import 'package:flutter_proben/vector2.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'physic_frames.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final appstate = Appstate();

  Player player1 = Player(
      size: appstate.defaultPlayerSize,
      position: Vector2(
          x: appstate.defaultPlayGroundWidth - appstate.defaultPlayerSize,
          y: appstate.defaultPlayGroundHeight - appstate.defaultPlayerSize),
      face: smileFace);
  Player player2 = Player(
    size: appstate.defaultPlayerSize,
    position: Vector2(),
    face: lovelyFace,
  );
  Ball whiteBall = Ball(
    opacity: 0,
    size: appstate.defaultBallSize,
    position: Vector2(
        x: (appstate.defaultPlayGroundWidth - appstate.defaultPlayerSize) / 2,
        y: (appstate.defaultPlayGroundHeight - appstate.defaultPlayerSize) / 2),
  );
  Ball blackBall = Ball(
    opacity: 0,
    size: appstate.defaultBallSize,
    position: Vector2(
        x: (appstate.defaultPlayGroundWidth - appstate.defaultPlayerSize) / 2,
        y: (appstate.defaultPlayGroundHeight - appstate.defaultPlayerSize) / 2),
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
    appstate.defaultPlayGroundHeight = 0.8 * height;
    appstate.defaultPlayGroundWidth = 0.8 * width;

    if (appstate.playingMode) {
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        final delay = Duration(microseconds: (20000 - (duration - lastFrame).inMicroseconds));
        Future.delayed(
            delay,
            () => setState(() {
                  appstate.playRools(player1, player2, whiteBall, blackBall);
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
                    Icons.stop,
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
                  child: Icon(Icons.refresh)),
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
                        padding: EdgeInsets.fromLTRB(
                            appstate.defaultPlayGroundWidth / 4, 10, appstate.defaultPlayGroundWidth / 4, 10),
                        child: Text(
                          '${player2.name ?? 'Player2'} : ${player2.score}',
                          style: const TextStyle(color: Colors.blue, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: appstate.defaultPlayGroundWidth / 4),
                        child: Text(
                          '${player1.name ?? 'Player1'} : ${player1.score}',
                          style: const TextStyle(color: Colors.red, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                  if (player1.score > 9)
                    Container(
                      color: Colors.green,
                      height: appstate.defaultPlayGroundHeight,
                      width: appstate.defaultPlayGroundWidth,
                      child: Center(
                        child: Text(
                          '${player1.name ?? 'Player1'} Wins',
                          style: const TextStyle(color: Colors.red, fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  else if (player2.score > 9)
                    Container(
                      color: Colors.green,
                      height: appstate.defaultPlayGroundHeight,
                      width: appstate.defaultPlayGroundWidth,
                      child: Center(
                        child: Text(
                          '${player2.name ?? 'Player2'} Wins',
                          style: const TextStyle(color: Colors.blue, fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  else
                    Container(
                      height: appstate.defaultPlayGroundHeight,
                      width: appstate.defaultPlayGroundWidth,
                      color: Colors.green,
                      child: Stack(
                        children: [
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
                            child: Center(
                              child: Container(
                                height: whiteBall.size,
                                width: whiteBall.size,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(whiteBall.opacity, 255, 255, 255),
                                  border: Border.all(width: 2, color: Color.fromARGB(whiteBall.opacity, 0, 0, 0)),
                                  borderRadius: BorderRadius.circular(whiteBall.size),
                                ),
                              ),
                            ),
                          ),
                          //Black Ball
                          Positioned(
                            left: blackBall.position.x,
                            top: blackBall.position.y,
                            child: Center(
                              child: Container(
                                height: blackBall.size,
                                width: blackBall.size,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(blackBall.opacity, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(blackBall.size),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
