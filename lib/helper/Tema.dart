import 'package:flutter/material.dart';
import 'package:jmcare/helper/Warna.dart';
import 'package:pinput/pinput.dart';

class Tema{


  static PinTheme temaPin(){
    return PinTheme(
      height: 60,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: Colors.green),
      ),
    );
  }

  static Text buttonText(String teks){
    return Text(teks, style: const TextStyle(color: Colors.white));
  }

  static Decoration getBackgroundLogin(){
    return const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/bg_login.png"),
            fit: BoxFit.cover
        )
    );
  }

  static InputDecoration roundedTextField(){
    return InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black12,
            style: BorderStyle.solid,
          ),
        ),

        filled: true,
        fillColor: Colors.white60);
  }

  static ElevatedButtonThemeData tombol(){
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: const BorderSide(color: Warna.hijau),
            )
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.lightGreen;
          }
          return Warna.hijau;
        }),
        textStyle: MaterialStateProperty.resolveWith((states) {
          return const TextStyle(color: Colors.white);
        }),

      ),
    );
  }
}