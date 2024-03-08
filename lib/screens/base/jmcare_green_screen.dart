import 'package:flutter/material.dart';
import '../../helper/Komponen.dart';
import '../../helper/Tema.dart';

class JmcareGreenScreen extends StatelessWidget {

  final String? title;
  final Widget? body;

  const JmcareGreenScreen({super.key, this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: Tema.getBackgroundLogin() ,
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 60),
            child: ListView(
              children: [
                Komponen.getLogoHijau(),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                  child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      elevation: 5,
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: body
                      )
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: const Text("JACCS MPM Finance Indonesia berizin dan diawasi Otoritas Jasa Keuangan (OJK)",
                textAlign: TextAlign.center,
              ),
            )
          ),
        ],
      )
    );
  }
}