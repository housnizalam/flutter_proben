import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_proben/logik/Klassen.dart';
import 'package:flutter_proben/logik/emojis.dart';
import 'package:flutter_proben/logik/vector2.dart';


class Appstate {
//**************** Main variabels **************************************************
  bool gameOver = false;
  String winner = '';
  double playGroundHeight = 500;
  double playGroundWidth = 500;
  double playerSize = 50;
  double foodSize = 20;
  int speed = 3;
  bool playingMode = false;
  bool stoped = false;
  bool player1EatsTheBanana = false;
  bool player2EatsTheBanana = false;
  final sounEffect = SounEffect();
  final emojies = Emojies();
  //**************** Main functions **************************************************

  playingRools(Player player1, Player player2, Ball hamburger, Ball banana) {
    dimensionsConvenience(player1, player2, hamburger, banana);
//checking if player1 close enough from hamburger or banana to oppen his mouth
    if (player1CloseToOpenmouth(player1, hamburger) || player1CloseToOpenmouth(player1, banana)) {
      player1.face = emojies.smileFaceEating;
    } else if (!player1EatsTheBanana && !player2EatsTheBanana) {
      player1.face = emojies.smileFace;
    }
//checking if player1 close enough from hamburger or banana to eat the humberger
    if (player1CloseToEat(player1, player2, hamburger)) {
      sounEffect.eatHamburger();
      player2.speed += 0.2;
      player1.score++;
      hamburger.position.x = Random().nextInt((playGroundWidth - playerSize + 1).toInt()).toDouble();
      hamburger.position.y = Random().nextInt((playGroundHeight - playerSize + 1).toInt()).toDouble();
    }
//checking if player2 close enough from hamburger or banana to oppen his mouth
    if (player2CloseToOpenmouth(player2, hamburger) || player2CloseToOpenmouth(player2, banana)) {
      player2.face = emojies.lovelyFaceEating;
    } else if (!player1EatsTheBanana && !player2EatsTheBanana) {
      player2.face = emojies.lovelyFace;
    }
//checking if player2 close enough from hamburger or banana to eat the humberger
    if (player2CloseToEat(player2, player1, hamburger)) {
      sounEffect.eatHamburger();

      player1.speed += 0.2;
      player2.score++;
      hamburger.position.x = Random().nextInt((playGroundWidth - playerSize + 1).toInt()).toDouble();
      hamburger.position.y = Random().nextInt((playGroundHeight - playerSize + 1).toInt()).toDouble();
    }
//checking if player1 close enough from hamburger or banana to eat the banana
    if (player1CloseToEat(player1, player2, banana)) {
      sounEffect.laugh();
      banana.position.x = Random().nextInt((playGroundWidth - playerSize + 1).toInt()).toDouble();
      banana.position.y = Random().nextInt((playGroundHeight - playerSize + 1).toInt()).toDouble();
      player2.speed = 0;
      player1EatsTheBanana = true;
      player2.face = emojies.freazed;
      player1.face = emojies.crazy;
      Future.delayed(const Duration(seconds: 3), () {
        player2.speed = 3;
        player2.face = emojies.lovelyFace;
        player1.face = emojies.smileFace;
        player1EatsTheBanana = false;
        if (playGroundHeight > 750 && playGroundWidth > 750) {
          player2.speed = 4;
        }
      });
    }
//checking if player2 close enough from hamburger or banana to eat the banana

    if (player2CloseToEat(player2, player1, banana)) {
      sounEffect.laugh();

      player1.speed = 0;
      banana.position.x = Random().nextInt((playGroundWidth - playerSize + 1).toInt()).toDouble();
      banana.position.y = Random().nextInt((playGroundHeight - playerSize + 1).toInt()).toDouble();
      player2EatsTheBanana = true;
      player1.face = emojies.sick;
      player2.face = emojies.crazy;
      Future.delayed(const Duration(seconds: 3), () {
        player1.speed = 3;
        player1.face = emojies.smileFace;
        player2.face = emojies.lovelyFace;
        player2EatsTheBanana = false;
        if (playGroundHeight > 750 && playGroundWidth > 750) {
          player1.speed = 4;
          player1.face = emojies.smileFace;
          player2.face = emojies.lovelyFace;
          player2EatsTheBanana = false;
        }
      });
    }
  }

  // To start the game from beginn or to start after puss
  playBottun(Player player1, Player player2, Ball humburger, Ball banana) {
    // To start after puss
    if (stoped) {
      stoped = false;
      playingMode = true;
    } else if (!playingMode) {
      sounEffect.gameStart();
      dimensionsConvenience(player1, player2, humburger, banana);
      humburger.body = emojies.hamburger;
      banana.body = emojies.banana;
      playingMode = true;
      gameOver = false;
      player1.speed = 3;
      player2.speed = 3;
      if (playGroundHeight > 750 && playGroundWidth > 750) {
        player1.speed = 4;
        player2.speed = 4;
      }
      player1.position.x = playGroundWidth - player1.size;
      player1.position.y = playGroundHeight - player1.size;
      humburger.position.x = Random().nextInt((playGroundWidth - playerSize + 1).toInt()).toDouble();
      humburger.position.y = Random().nextInt((playGroundHeight - playerSize + 1).toInt()).toDouble();
      banana.position.x = Random().nextInt((playGroundWidth - playerSize + 1).toInt()).toDouble();
      banana.position.y = Random().nextInt((playGroundHeight - playerSize + 1).toInt()).toDouble();
    }
  }

// To end the game
  gameEnds(Player player1, Player player2, Ball hamburger, Ball banana) {
    if (player1.score > 9) {
      sounEffect.win();
      winner = player1.name ?? '';
      player1.face = emojies.empty;
      player2.face = emojies.empty;
      hamburger.body = emojies.empty;
      banana.body = emojies.empty;
      player1.moveDirection.y = 0;
      player1.moveDirection.x = 0;
      player2.moveDirection.y = 0;
      player2.moveDirection.x = 0;
      gameOver = true;
      playingMode = false;
      player1.score = 0;
      player2.score = 0;
    } else if (player2.score > 9) {
      sounEffect.win();
      winner = player2.name ?? '';
      player1.face = emojies.empty;
      player2.face = emojies.empty;
      hamburger.body = emojies.empty;
      banana.body = emojies.empty;
      player1.moveDirection.y = 0;
      player1.moveDirection.x = 0;
      player2.moveDirection.y = 0;
      player2.moveDirection.x = 0;
      gameOver = true;

      playingMode = false;
      player1.score = 0;
      player2.score = 0;
    }
  }

// To restart the game
  restart(Player player1, Player player2, Ball hamburger, Ball banana) {
    sounEffect.gameStart();

    hamburger.body = emojies.hamburger;
    banana.body = emojies.banana;
    player1.score = 0;
    player2.score = 0;
    player1.speed = 3;
    player2.speed = 3;
    if (playGroundHeight > 750 && playGroundWidth > 750) {
      player1.speed = 4;
      player2.speed = 4;
    }
    player1.position.x = playGroundWidth - player1.size;
    player1.position.y = playGroundHeight - player1.size;
    player2.position.x = 0;
    player2.position.y = 0;
    hamburger.position.x = Random().nextInt((playGroundWidth - playerSize + 1).toInt()).toDouble();
    hamburger.position.y = Random().nextInt((playGroundHeight - playerSize + 1).toInt()).toDouble();
    banana.position.x = Random().nextInt((playGroundWidth - playerSize + 1).toInt()).toDouble();
    banana.position.y = Random().nextInt((playGroundHeight - playerSize + 1).toInt()).toDouble();
  }

  //**************** Hilfs functions **************************************************
// Defining if player1 colse enough to eat the hamburger
  bool player1CloseToEat(Player player1, Player player2, Ball whiteBall) {
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

// Defining if player1 colse enough to open his mouth
  bool player1CloseToOpenmouth(
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

// Defining if player2 colse enough to eat the hamburger
  bool player2CloseToEat(Player player1, Player player2, Ball whiteBall) {
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

// Defining if player2 colse enough to open his mouth
  bool player2CloseToOpenmouth(
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

//Makes the element size propotional with the screen
  dimensionsConvenience(
    Player player1,
    Player player2,
    Ball hamburger,
    Ball banana,
  ) {
    double size = playGroundWidth;
    if (playGroundHeight < playGroundWidth) {
      size = playGroundHeight;
    }
    if (size < 680) {
      player1.size = 50;
      player2.size = 50;
      hamburger.size = 20;
      banana.size = 20;
    } else {
      player1.size = size / 13;
      player2.size = size / 13;
      hamburger.size = size / 27;
      banana.size = size / 27;
    }
  }
//**************** Keyboard functions **************************************************

  player1Up(Player player1, Vector2 dirPlayer1) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.arrowUp,
    )) {
      if (player1.position.y < -playerSize * 0.7) {
        player1.position.y = playGroundHeight - playerSize * 0.2;
      } else {
        dirPlayer1.y--;
      }
    }
  }

  player1Down(Player player1, Vector2 dirPlayer1) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.arrowDown,
    )) {
      if (player1.position.y > playGroundHeight - playerSize * 0.3) {
        player1.position.y = -playerSize * 0.8;
      } else {
        dirPlayer1.y++;
      }
    }
  }

  player1Right(Player player1, Vector2 dirPlayer1) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.arrowRight,
    )) {
      if (player1.position.x > playGroundWidth - playerSize * 0.3) {
        player1.position.x = -playerSize * 0.8;
      } else {
        dirPlayer1.x++;
      }
    }
  }

  player1Left(Player player1, Vector2 dirPlayer1) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.arrowLeft,
    )) {
      if (player1.position.x < -playerSize * 0.6) {
        player1.position.x = playGroundWidth - playerSize * 0.2;
      } else {
        dirPlayer1.x--;
      }
    }
  }

  player2Up(Player player2, Vector2 dirPlayer2) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.keyW,
    )) {
      if (player2.position.y < -playerSize * 0.7) {
        player2.position.y = playGroundHeight - playerSize * 0.4;
      } else {
        dirPlayer2.y--;
      }
    }
  }

  player2Down(Player player2, Vector2 dirPlayer2) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.keyS,
    )) {
      if (player2.position.y > playGroundHeight - playerSize * 0.6) {
        player2.position.y = -playerSize;
      } else {
        dirPlayer2.y++;
      }
    }
  }

  player2Right(Player player2, Vector2 dirPlayer2) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.keyD,
    )) {
      if (player2.position.x > playGroundWidth - playerSize * 0.2) {
        player2.position.x = -playerSize * 0.8;
      } else {
        dirPlayer2.x++;
      }
    }
  }

  player2Left(Player player2, Vector2 dirPlayer2) {
    if (RawKeyboard.instance.keysPressed.contains(
      LogicalKeyboardKey.keyA,
    )) {
      if (player2.position.x < -playerSize * 0.8) {
        player2.position.x = playGroundWidth - playerSize * 0.2;
      } else {
        dirPlayer2.x--;
      }
    }
  }
}
