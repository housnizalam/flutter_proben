import 'dart:math';

import 'package:flutter_proben/physic_frames.dart';

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
    blackBall.position.x = Random().nextInt(451).toDouble();
    blackBall.position.y = Random().nextInt(451).toDouble();
    player2.speed = 0;
    Future.delayed(const Duration(seconds: 3), () {
      player2.speed = 2;
    });
  }
  if ((player2.position.x - blackBall.position.x).abs() < player2.size / 2 &&
      (player2.position.y - blackBall.position.y).abs() < player2.size / 2) {
    player1.speed = 0;
    blackBall.position.x = Random().nextInt(451).toDouble();
    blackBall.position.y = Random().nextInt(451).toDouble();
    Future.delayed(const Duration(seconds: 3), () {
      player1.speed = 2;
    });
  }
}

playBottun(Player player1, Player player2, bool play, Ball whiteBall, Ball blackBall) {
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
