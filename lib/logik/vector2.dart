import 'dart:math';

class Vector2 {
  double x;
  double y;
  Vector2({this.x = 0, this.y = 0});

  Vector2 normalized() {
    if (x == 0 && y == 0) return Vector2();
    double _magnitude = magnitude();
    return Vector2(
      x: x / _magnitude,
      y: y / _magnitude,
    );
  }

  double magnitude() => sqrt(x * x + y * y);
}
