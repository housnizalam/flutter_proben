// ignore_for_file: public_member_api_docs, sort_constructors_first

class Spieler {
  static int _id = 0;

  String name;
  int power;
  int spielerId;
  Spieler({
    required this.name,
    required this.power,
  }) : spielerId = _id {
    _id++;
  }

  @override
  String toString() => 'Name: $name, Power: $power, SpielerId: $spielerId';
}

// Ball({
//   required this.fromRight,
//   required this.fromTop,
// })
class Ball {
  int fromRight;
  int fromTop;
  Ball({
    required this.fromRight,
    required this.fromTop,
  });
  int opacity = 450;
}
List<Spieler> spielers = [];
