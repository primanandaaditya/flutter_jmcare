
import 'dart:ui';

import 'package:get/get.dart';
import 'package:jmcare/screens/resetpassword/webview/state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ResetPasswordWebViewLogic extends GetxController{

  final ResetPasswordWebViewState state = ResetPasswordWebViewState();

  @override
  void onInit() {
    super.onInit();
    initWebView();
  }

  void initWebView(){
    state.webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('http://mitra.mpm-finance.com/rpm-mobile/forgot-password-jmcare.aspx'));
  }

}
