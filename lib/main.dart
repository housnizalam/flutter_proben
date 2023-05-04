import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_proben/appstate.dart';
import 'package:flutter_proben/home.dart';
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


