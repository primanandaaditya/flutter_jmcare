import 'package:flutter/material.dart';
import '../../helper/Komponen.dart';
import '../../helper/Tema.dart';

class JmcareBarScreen extends StatelessWidget {
  final String? title;
  final Widget? body;
  const JmcareBarScreen({super.key, this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Komponen.getAppBar(context, this.title!),
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: body
      ),
    );
  }
}