// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_proben/test/klassen2.dart';
import 'package:flutter_proben/vector2.dart';

abstract class PhysicFrames {
  static int fps = 50;
  static bool _isInitialized = false;
  static DateTime? _lastFrame;

  static List<Function> listeners = [];

  static void addListener(Function newListener) {
    listeners.add(newListener);
  }

  static void removeListener(Function toRemove) {
    listeners.remove(toRemove);
  }

  static void init() {
    if (_isInitialized) return;
    _isInitialized = true;
    //_frame(); //First Frame
    Timer.periodic(Duration(milliseconds: 1000 ~/ fps), (_) => _frame());
  }

  static void _frame() async {
    // Future.delayed(Duration(milliseconds: 1000 ~/ fps), _frame);
    final currentFrame = DateTime.now();
    if ((currentFrame.millisecond - (_lastFrame?.millisecond ?? 999)) < 35) {
      for (var listener in listeners) {
        listener();
      }
    } else {
      print('Not OK');
    }
    _lastFrame = currentFrame;
  }
}

class Player {
  String? Name;
  double speed;
  double size;
  int score;
  int opacity = 250;
  Vector2 position;
  Vector2 moveDirection;
  Player({
    required this.speed,
    required this.score,
    required this.position,
    required this.size,
  }) : moveDirection = Vector2();
  void move() {
    final normalized = moveDirection.normalized();

    position.x += normalized.x * speed;
    position.y += normalized.y * speed;
  }
}

class Ball {
  int opacity;
  double size;

  Vector2 position;
  Vector2 direction;
  Ball({
    required this.opacity,
    required this.size,
    required this.position,
  }) : direction = Vector2();
  void move() {
    final normalized = direction.normalized();
    position.x += normalized.x;
    position.y += normalized.y;
  }
}

PlayRools(Player player1, Player player2, Ball whiteBall, Ball blackBall) {
  if ((player1.position.x - whiteBall.position.x).abs() < player1.size / 2 &&
      (player1.position.y - whiteBall.position.y).abs() < player1.size / 2) {
    player2.speed += 0.2;
    player1.score++;
    whiteBall.position.x = Random().nextInt(451).toDouble();
    whiteBall.position.y = Random().nextInt(451).toDouble();
  }
  if ((player2.position.x - whiteBall.position.x).abs() < player2.size / 2 &&
      (player2.position.y - whiteBall.position.y).abs() < player2.size / 2) {
    player1.speed += 0.2;
    player2.score++;
    whiteBall.position.x = Random().nextInt(451).toDouble();
    whiteBall.position.y = Random().nextInt(451).toDouble();
  }
  if ((player1.position.x - blackBall.position.x).abs() < player1.size / 2 &&
      (player1.position.y - blackBall.position.y).abs() < player1.size / 2) {
    player2.speed /= 100;
    blackBall.position.x = Random().nextInt(451).toDouble();
    blackBall.position.y = Random().nextInt(451).toDouble();
    Future.delayed(const Duration(seconds: 3), () {
      player2.speed *= 100;
    });
  }
  if ((player2.position.x - blackBall.position.x).abs() < player2.size / 2 &&
      (player2.position.y - blackBall.position.y).abs() < player2.size / 2) {
    player1.speed /= 100;
    blackBall.position.x = Random().nextInt(451).toDouble();
    blackBall.position.y = Random().nextInt(451).toDouble();
    Future.delayed(const Duration(seconds: 3), () {
      player1.speed *= 100;
    });
  }
}

 playBottun(Player player1,Player player2,bool play,Ball whiteBall,Ball blackBall){
     if (player1.score > 9 || player2.score > 9) {
            play = false;
            player1.score = 0;
            player2.score = 0;
            player1.speed = 1;
            player2.speed = 1;
            player1.position.x = 450;
            player1.position.y = 450;
            player2.position.x = 0;
            player2.position.y = 0;
          }
          if (!play) {
            whiteBall.opacity = 450;
            blackBall.opacity = 450;
            whiteBall.position.x = Random().nextInt(451).toDouble();
            whiteBall.position.y = Random().nextInt(451).toDouble();
            blackBall.position.x = Random().nextInt(451).toDouble();
            blackBall.position.y = Random().nextInt(451).toDouble();
            play = true;
          }
 }
