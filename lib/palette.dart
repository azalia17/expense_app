import 'package:flutter/material.dart';

Color primaryColor = Color(0xFFCADCED);

List<BoxShadow> customShadow = [
  BoxShadow(
      color: Colors.white.withOpacity(0.5),
      spreadRadius: -5,
      offset: Offset(-5, -5),
      blurRadius: 30
  ),
  BoxShadow(
      color: Colors.blue[900].withOpacity(.2),
      spreadRadius: 2,
      offset: Offset(7, 7),
      blurRadius: 20
  ),
];

class Palette{
  static const Color scaffold = Color(0xFFF0F2F5);

  static const Color ijo = Color(0xFF2DB74C);
  static const Color ijo1 = Color(0xFFCBEDD2);

  static const Color abu = Color(0xFFC4C4C4);

  static const Color merah = Color(0xFFEB5757);
  static const Color merah1 = Color(0xFFFB7B7B);
  static const Color merah2 = Color(0xFFFFA0A0);

  static const Color biru = Color(0xFF2D9CDB);
  static const Color biru1 = Color(0xFF49B9F9);
  static const Color biru2 = Color(0xFF6AC9FF);
}