import 'dart:ui';
import 'package:flutter/material.dart';

class Warna{

  static const MaterialColor hijau = MaterialColor(
    0xff196f3d, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50:  Color.fromRGBO(213, 245, 227, 0.8),
      100:  Color.fromRGBO(213, 245, 227, 1.0),
      200:  Color.fromRGBO(171, 235, 198, 1.0),
      300:  Color.fromRGBO(125, 206, 160, 1.0),
      400:  Color.fromRGBO(82, 190, 128, 1.0),
      500:  Color.fromRGBO(39, 174, 96, 1.0),
      600:  Color.fromRGBO(34, 153, 84, 1.0),
      700:  Color.fromRGBO(30, 132, 73, 1.0),
      800:  Color.fromRGBO(25, 111, 61, 1.0),
      900:  Color.fromRGBO(20,90,50, 1.0),//100%
    },
  );



}