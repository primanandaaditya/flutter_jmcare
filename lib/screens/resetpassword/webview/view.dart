import 'package:flutter/material.dart';
import 'package:jmcare/screens/resetpassword/webview/logic.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class ResetPasswordWebView extends StatelessWidget {
  const ResetPasswordWebView({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ResetPasswordWebViewLogic());
    final state = Get.find<ResetPasswordWebViewLogic>().state;

    return GetBuilder<ResetPasswordWebViewLogic>(
      assignId: true,
        builder: (logic){
        return Scaffold(
          body: WebViewWidget(
            controller: logic.state.webViewController!,
          ),
        );
        }
    );
  }
}
