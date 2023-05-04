import 'package:flutter_proben/vector2.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class Player {
  late Emoji face;
  bool freazed = false;
  int score = 0;
  String? name;
  double speed = 0;
  double size;
  int opacity = 0;
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
  int opacity;
  double size;
  Vector2 position;
  Ball({
    required this.opacity,
    required this.size,
    required this.position,
  });
}
