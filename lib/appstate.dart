import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_proben/Klassen.dart';
import 'package:flutter_proben/emojis.dart';
import 'package:flutter_proben/physic_frames.dart';
import 'package:flutter_proben/vector2.dart';

class Appstate {
  double defaultPlayGroundHeight = 500;
  double defaultPlayGroundWidth = 500;
  double defaultPlayerSize = 50;
  double defaultBallSize = 20;
  int defaultSpeed = 2;
  bool playingMode = false;
  bool stoped = false;
  bool player1EatTheBall = false;
  bool player2EatTheBall = false;
  bool eatDistansdefinition(Player player1, Player player2, Ball whiteBall) {
    bool kommingFromLeft = false;
    if (whiteBall.position.x - player1.position.x < player1.size / 2) {
      kommingFromLeft = true;
    }
    bool kommingFromRight = false;
    if (player1.position.x - whiteBall.position.x < player1.size / 2 - player1.size * 0.46) {
      kommingFromRight = true;
    }
    bool kommingFromUp = false;
    if (whiteBall.position.y - player1.position.y < player1.size / 2 + player1.size * 0.23) {
      kommingFromUp = true;
    }
    bool kommingFromDown = false;
    if (player1.position.y - whiteBall.position.y < player1.size / 2 - player1.size * 0.46) {
      kommingFromDown = true;
    }
    bool eat = false;
    if ((kommingFromLeft && kommingFromRight) && (kommingFromUp && kommingFromDown)) {
      eat = true;
    }
    return eat;
  }

  bool playerNear(
    Player player1,
    Ball whiteBall,
  ) {
    bool kommingFromLeft = false;
    if (whiteBall.position.x - player1.position.x < player1.size / 2 + whiteBall.size) {
      kommingFromLeft = true;
    }
    bool kommingFromRight = false;
    if (player1.position.x - whiteBall.position.x < player1.size / 2 - player1.size * 0.46 + whiteBall.size) {
      kommingFromRight = true;
    }
    bool kommingFromUp = false;
    if (whiteBall.position.y - player1.position.y < player1.size / 2 + player1.size * 0.23 + whiteBall.size) {
      kommingFromUp = true;
    }
    bool kommingFromDown = false;
    if (player1.position.y - whiteBall.position.y < player1.size / 2 - player1.size * 0.46 + whiteBall.size) {
      kommingFromDown = true;
    }
    bool eat = false;
    if ((kommingFromLeft && kommingFromRight) && (kommingFromUp && kommingFromDown)) {
      eat = true;
    }
    return eat;
  }

  bool eatDistansdefinition2(Player player1, Player player2, Ball whiteBall) {
    bool kommingFromLeft = false;
    if (whiteBall.position.x - player1.position.x < player1.size / 2 + player1.size * 0.46) {
      kommingFromLeft = true;
    }
    bool kommingFromRight = false;
    if (player1.position.x - whiteBall.position.x < player1.size / 2 - player1.size * 0.46) {
      kommingFromRight = true;
    }
    bool kommingFromUp = false;
    if (whiteBall.position.y - player1.position.y < player1.size / 2 + player1.size * 0.46) {
      kommingFromUp = true;
    }
    bool kommingFromDown = false;
    if (player1.position.y - whiteBall.position.y < player1.size / 2 - player1.size * 0.92) {
      kommingFromDown = true;
    }
    bool eat = false;
    if ((kommingFromLeft && kommingFromRight) && (kommingFromUp && kommingFromDown)) {
      eat = true;
    }
    return eat;
  }

  bool playerNear2(
    Player player1,
    Ball whiteBall,
  ) {
    bool kommingFromLeft = false;
    if (whiteBall.position.x - player1.position.x < player1.size / 2 + player1.size * 0.46 + whiteBall.size) {
      kommingFromLeft = true;
    }
    bool kommingFromRight = false;
    if (player1.position.x - whiteBall.position.x < player1.size / 2 - player1.size * 0.46 + whiteBall.size) {
      kommingFromRight = true;
    }
    bool kommingFromUp = false;
    if (whiteBall.position.y - player1.position.y < player1.size / 2 + player1.size * 0.46 + whiteBall.size) {
      kommingFromUp = true;
    }
    bool kommingFromDown = false;
    if (player1.position.y - whiteBall.position.y < player1.size / 2 - player1.size * 0.92 + whiteBall.size) {
      kommingFromDown = true;
    }
    bool eat = false;
    if ((kommingFromLeft && kommingFromRight) && (kommingFromUp && kommingFromDown)) {
      eat = true;
    }
    return eat;
  }
  // oldEatKondition(){
  //  (player1.position.x - whiteBall.position.x).abs() < player1.size / 2 &&
  //       (player1.position.y - whiteBall.position.y).abs() < player1.size / 2
  // }

  playRools(Player player1, Player player2, Ball whiteBall, Ball blackBall) {
    playerWithMonitorConvenience(player1, player2, whiteBall, blackBall);
    if (playerNear(player1, whiteBall) || playerNear(player1, blackBall)) {
      player1.face = smileEat;
    } else if (!player1EatTheBall && !player2EatTheBall) {
      player1.face = smileFace;
    }
    if (eatDistansdefinition(player1, player2, whiteBall)) {
      player2.speed += 0.2;
      player1.score++;
      whiteBall.position.x = Random().nextInt((defaultPlayGroundWidth - defaultPlayerSize + 1).toInt()).toDouble();
      whiteBall.position.y = Random().nextInt((defaultPlayGroundHeight - defaultPlayerSize + 1).toInt()).toDouble();
    }
    if (playerNear2(player2, whiteBall) || playerNear2(player2, blackBall)) {
      player2.face = loveEat;
    } else if (!player1EatTheBall && !player2EatTheBall) {
      player2.face = lovelyFace;
    }
    if (eatDistansdefinition2(player2, player1, whiteBall)) {
      player1.speed += 0.2;
      player2.score++;
      whiteBall.position.x = Random().nextInt((defaultPlayGroundWidth - defaultPlayerSize + 1).toInt()).toDouble();
      whiteBall.position.y = Random().nextInt((defaultPlayGroundHeight - defaultPlayerSize + 1).toInt()).toDouble();
    }
    if (eatDistansdefinition(player1, player2, blackBall)) {
      blackBall.position.x = Random().nextInt((defaultPlayGroundWidth - defaultPlayerSize + 1).toInt()).toDouble();
      blackBall.position.y = Random().nextInt((defaultPlayGroundHeight - defaultPlayerSize + 1).toInt()).toDouble();
      player2.speed = 0;
      player1EatTheBall = true;
      player2.face = freazed;
      player1.face = crazy;
      Future.delayed(const Duration(seconds: 3), () {
        player2.speed = 3;
        player2.face = lovelyFace;
        player1.face = smileFace;
        player1EatTheBall = false;
        if (defaultPlayGroundHeight > 750 && defaultPlayGroundWidth > 750) {
          player2.speed = 4;
          player2.face = lovelyFace;
          player1.face = smileFace;
          player1EatTheBall = false;
        }
      });
    }
    if (eatDistansdefinition2(player2, player1, blackBall)) {
      player1.speed = 0;
      blackBall.position.x = Random().nextInt((defaultPlayGroundWidth - defaultPlayerSize + 1).toInt()).toDouble();
      blackBall.position.y = Random().nextInt((defaultPlayGroundHeight - defaultPlayerSize + 1).toInt()).toDouble();
      player2EatTheBall = true;
      player1.face = sick;
      player2.face = crazy;
      Future.delayed(const Duration(seconds: 3), () {
        player1.speed = 3;
        player1.face = smileFace;
        player2.face = lovelyFace;
        player2EatTheBall = false;
        if (defaultPlayGroundHeight > 750 && defaultPlayGroundWidth > 750) {
          player1.speed = 4;
          player1.face = smileFace;
          player2.face = lovelyFace;
          player2EatTheBall = false;
        }
      });
    }
  }

  playBottun(Player player1, Player player2, Ball whiteBall, Ball blackBall) {
    if (player1.score > 9 || player2.score > 9) {
      restart(player1, player2, whiteBall, blackBall);
    } else if (stoped) {
      stoped = false;
      playingMode = true;
    } else if (!playingMode) {
      playerWithMonitorConvenience(player1, player2, whiteBall, blackBall);
      playingMode = true;
      player1.speed = 3;
      player2.speed = 3;
      if (defaultPlayGroundHeight > 750 && defaultPlayGroundWidth > 750) {
        player1.speed = 4;
        player2.speed = 4;
      }
      player1.opacity = 255;
      player2.opacity = 200;
      whiteBall.opacity = 255;
      blackBall.opacity = 255;
      player1.position.x = defaultPlayGroundWidth - player1.size;
      player1.position.y = defaultPlayGroundHeight - player1.size;
      whiteBall.position.x = Random().nextInt((defaultPlayGroundWidth - defaultPlayerSize + 1).toInt()).toDouble();
      whiteBall.position.y = Random().nextInt((defaultPlayGroundHeight - defaultPlayerSize + 1).toInt()).toDouble();
      blackBall.position.x = Random().nextInt((defaultPlayGroundWidth - defaultPlayerSize + 1).toInt()).toDouble();
      blackBall.position.y = Random().nextInt((defaultPlayGroundHeight - defaultPlayerSize + 1).toInt()).toDouble();
    }
  }

  playerWithMonitorConvenience(
    Player player1,
    Player player2,
    Ball whiteBall,
    Ball blackBall,
  ) {
    double size = defaultPlayGroundWidth;
    if (defaultPlayGroundHeight < defaultPlayGroundWidth) {
      size = defaultPlayGroundHeight;
    }
    if (size < 680) {
      player1.size = 50;
      player2.size = 50;
      whiteBall.size = 20;
      blackBall.size = 20;
    } else {
      player1.size = size / 13;
      player2.size = size / 13;
      whiteBall.size = size / 34;
      blackBall.size = size / 34;
    }
  }

  restart(Player player1, Player player2, Ball whiteBall, Ball blackBall) {
    player1.score = 0;
    player2.score = 0;
    player1.speed = 3;
    player2.speed = 3;
    if (defaultPlayGroundHeight > 750 && defaultPlayGroundWidth > 750) {
      player1.speed = 4;
      player2.speed = 4;
    }
    player1.position.x = defaultPlayGroundWidth - player1.size;
    player1.position.y = defaultPlayGroundHeight - player1.size;
    player2.position.x = 0;
    player2.position.y = 0;
    whiteBall.position.x = Random().nextInt((defaultPlayGroundWidth - defaultPlayerSize + 1).toInt()).toDouble();
    whiteBall.position.y = Random().nextInt((defaultPlayGroundHeight - defaultPlayerSize + 1).toInt()).toDouble();
    blackBall.position.x = Random().nextInt((defaultPlayGroundWidth - defaultPlayerSize + 1).toInt()).toDouble();
    blackBall.position.y = Random().nextInt((defaultPlayGroundHeight - defaultPlayerSize + 1).toInt()).toDouble();
  }

  player1Up(Player player1, Vector2 dirPlayer1) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.arrowUp,
    )) {
      if (player1.position.y < -defaultPlayerSize * 0.8) {
        player1.position.y = defaultPlayGroundHeight - defaultPlayerSize * 0.2;
      } else {
        dirPlayer1.y--;
      }
    }
  }

  player1Down(Player player1, Vector2 dirPlayer1) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.arrowDown,
    )) {
      if (player1.position.y > defaultPlayGroundHeight - defaultPlayerSize * 0.2) {
        player1.position.y = -defaultPlayerSize * 0.8;
      } else {
        dirPlayer1.y++;
      }
    }
  }

  player1Right(Player player1, Vector2 dirPlayer1) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.arrowRight,
    )) {
      if (player1.position.x > defaultPlayGroundWidth - defaultPlayerSize * 0.2) {
        player1.position.x = -defaultPlayerSize * 0.8;
      } else {
        dirPlayer1.x++;
      }
    }
  }

  player1Left(Player player1, Vector2 dirPlayer1) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.arrowLeft,
    )) {
      if (player1.position.x < -defaultPlayerSize * 0.8) {
        player1.position.x = defaultPlayGroundWidth - defaultPlayerSize * 0.2;
      } else {
        dirPlayer1.x--;
      }
    }
  }

  player2Up(Player player2, Vector2 dirPlayer2) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.keyW,
    )) {
      if (player2.position.y < -defaultPlayerSize * 0.8) {
        player2.position.y = defaultPlayGroundHeight - defaultPlayerSize * 0.2;
      } else {
        dirPlayer2.y--;
      }
    }
  }

  player2Down(Player player2, Vector2 dirPlayer2) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.keyS,
    )) {
      if (player2.position.y > defaultPlayGroundHeight - defaultPlayerSize * 0.2) {
        player2.position.y = -defaultPlayerSize * 0.8;
      } else {
        dirPlayer2.y++;
      }
    }
  }

  player2Right(Player player2, Vector2 dirPlayer2) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.keyD,
    )) {
      if (player2.position.x > defaultPlayGroundWidth - defaultPlayerSize * 0.2) {
        player2.position.x = -defaultPlayerSize * 0.8;
      } else {
        dirPlayer2.x++;
      }
    }
  }

  player2Left(Player player2, Vector2 dirPlayer2) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.keyA,
    )) {
      if (player2.position.x < -defaultPlayerSize * 0.8) {
        player2.position.x = defaultPlayGroundWidth - defaultPlayerSize * 0.2;
      } else {
        dirPlayer2.x--;
      }
    }
  }
}
