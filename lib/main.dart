import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_proben/vector2.dart';

import 'physic_frames.dart';

void main() {
  PhysicFrames.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Eat the white ball'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Player player1 = Player(speed: 1, size: 50, score: 0, position: Vector2(x: 450, y: 450));
  Player player2 = Player(speed: 1, size: 50, score: 0, position: Vector2());
  Ball whiteBall = Ball(opacity: 0, size: 20, position: Vector2(x: 225, y: 255));
  Ball blackBall = Ball(opacity: 0, size: 20, position: Vector2(x: 225, y: 255));

  Duration lastFrame = Duration.zero;

  void keyCListener(RawKeyEvent event) {
    Vector2 dirPlayer1 = Vector2();
    Vector2 dirPlayer2 = Vector2();

//Player1 Movement
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.arrowUp,
    )) {
      if (player1.position.y < -40) {
        player1.position.y = 490;
      } else {
        dirPlayer1.y--;
      }
    }
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.arrowDown,
    )) {
      if (player1.position.y > 490) {
        player1.position.y = -40;
      } else {
        dirPlayer1.y++;
      }
    }

    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.arrowRight,
    )) {
      if (player1.position.x > 490) {
        player1.position.x = -40;
      } else {
        dirPlayer1.x++;
      }
    }
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.arrowLeft,
    )) {
      if (player1.position.x < -40) {
        player1.position.x = 490;
      } else {
        dirPlayer1.x--;
      }
    }

//Player2 Movement
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.keyW,
    )) {
      if (player2.position.y < -40) {
        player2.position.y = 490;
      } else {
        dirPlayer2.y--;
      }
    }
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.keyS,
    )) {
      if (player2.position.y > 490) {
        player2.position.y = -40;
      } else {
        dirPlayer2.y++;
      }
    }
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.keyD,
    )) {
      if (player2.position.x > 490) {
        player2.position.x = -40;
      } else {
        dirPlayer2.x++;
      }
    }
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.keyA,
    )) {
      if (player2.position.x < -40) {
        player2.position.x = 490;
      } else {
        dirPlayer2.x--;
      }
    }

    player1.moveDirection = dirPlayer1;
    player2.moveDirection = dirPlayer2;
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
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      final delay = Duration(microseconds: (20000 - (duration - lastFrame).inMicroseconds));
      Future.delayed(
          delay,
          () => setState(() {
                PlayRools(player1, player2, whiteBall, blackBall);
              }));
      lastFrame = duration;
    });
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {
          // final spieler = Spieler(name: 'Paul', power: 2);
          // spielers.add(spieler);
          playBottun(player1, player2, false, whiteBall, blackBall);
        },
        icon: const Icon(Icons.ad_units),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(120, 10, 120, 10),
                  child: Text(
                    '${player2.Name ?? 'Player2'} : ${player2.score}',
                    style: const TextStyle(color: Colors.blue, fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: Text(
                    '${player1.Name ?? 'Player1'} : ${player1.score}',
                    style: const TextStyle(color: Colors.red, fontSize: 25),
                  ),
                ),
              ],
            ),
            if (player1.score > 9)
              Container(
                color: Colors.amber,
                height: 500,
                width: 500,
                child: Center(
                  child: Text(
                    '${player1.Name ?? 'Player1'} Wins',
                    style: const TextStyle(color: Colors.red, fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            else if (player2.score > 9)
              Container(
                color: Colors.amber,
                height: 500,
                width: 500,
                child: Center(
                  child: Text(
                    '${player2.Name ?? 'Player2'} Wins',
                    style: const TextStyle(color: Colors.blue, fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            else
              Container(
                height: 500,
                width: 500,
                color: Colors.amber,
                child: Stack(
                  children: [
                    Positioned(
                      left: player1.position.x,
                      top: player1.position.y,
                      child: Center(
                        child: Container(
                          height: player1.size,
                          width: player1.size,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(player1.size),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: player2.position.x,
                      top: player2.position.y,
                      child: Center(
                        child: Container(
                          height: player2.size,
                          width: player2.size,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(200, 33, 149, 243),
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(player2.size),
                          ),
                        ),
                      ),
                    ),
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
