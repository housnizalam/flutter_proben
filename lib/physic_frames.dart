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

