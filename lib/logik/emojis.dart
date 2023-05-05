import 'package:flutter_emoji/flutter_emoji.dart';

class Emojies {
  static final parser = EmojiParser();

  final coffee = parser.get('coffee');
  final smileFace = Emoji('smileFace', '🙂');
  final lovelyFace = Emoji('lovelyFace', '🥰');
  final smileFaceEating = Emoji('smileEat', '😃');
  final lovelyFaceEating = Emoji('loveEat', '😍');
  final sick = Emoji('sick', '🤢');
  final freazed = Emoji('freazed', '🥶');
  final crazy = Emoji('happy', '🤪');
  final hamburger = Emoji('happy', '🍔');
  final banana = Emoji('happy', '🍌');

  final empty = Emoji('heart', '');
}
