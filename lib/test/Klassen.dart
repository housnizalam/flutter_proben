// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:math';

// class Spieler {
//   static final Random _random = Random();
//   static int _id = 0;
//   static int _minPower = 20;
//   static int _maxPower = 50;
//   static void setRandomPowerBound({required int min, required int max}) {
//     assert(min <= max);
//     _minPower = min;
//     _maxPower = max;
//   }

//   String name;
//   int power;
//   int spielerId;
//   Spieler({
//     required this.name,
//     int? power,
//   })  : spielerId = _id,
//         power = power ?? _random.nextInt(_maxPower - _minPower + 1) + _minPower {
//     _id++;
//   }

//   @override
//   String toString() => 'Name: $name, Power: $power, SpielerId: $spielerId';
// }

// List<Spieler> spielers = [];
