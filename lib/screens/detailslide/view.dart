import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';

class DetailslideScreen extends StatelessWidget {
  const DetailslideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final detail = Get.arguments['detail'];
    return JmcareBarScreen(
      title: "Keterangan",
      body: SingleChildScrollView(
        child: HtmlWidget(
          detail,
        ),
      )
    );
  }
}
