// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:audioplayers/audio_cache.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_proben/logik/vector2.dart';


class Player {
  late Emoji face;
  int score = 0;
  String? name;
  double speed = 0;
  double size;
  Vector2 position;
  Vector2 moveDirection;
  Player({
    required this.position,
    required this.size,
    required this.face,
  }) : moveDirection = Vector2();
  void move() {
    final normalized = moveDirection.normalized();

    position.x += normalized.x * speed;
    position.y += normalized.y * speed;
  }
}

class Ball {
  late Emoji body;
  double size;
  Vector2 position;
  Ball({
    required this.size,
    required this.body,
    required this.position,
  });
}

class SounEffect {
  AudioPlayer audioPlayer = AudioPlayer();

  eatHamburger() {
    final audioPlayer = AudioPlayer();
    // audioPlayer.audioCache = audioCache;
    return audioPlayer.play(DeviceFileSource('sounds/eathamburger.mp3'));
  }

  laugh() {
    final audioPlayer = AudioPlayer();
    // audioPlayer.audioCache = audioCache;
    return audioPlayer.play(DeviceFileSource('sounds/laugh.mp3'));
  }

  win() {
    final audioPlayer = AudioPlayer();
    // audioPlayer.audioCache = audioCache;
    return audioPlayer.play(DeviceFileSource('sounds/win.mp3'));
  }

  gameStart() {
    final audioPlayer = AudioPlayer();
    // audioPlayer.audioCache = audioCache;
    return audioPlayer.play(DeviceFileSource('sounds/gamestart.mp3'));
  }
}

// Future<AudioPlayer> eatHamburgerSound() async {
//     AudioCache cache = new AudioCache();
//    //At the next line, DO NOT pass the entire reference such as assets/yes.mp3. This will not work.
//    //Just pass the file name only.
//     return await cache.play("sounds/eathamburger.mp33"); 
// }
