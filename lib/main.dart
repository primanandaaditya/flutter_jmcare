import 'dart:io';
import 'package:dio/dio.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/screens/agreementcard/view.dart';
import 'package:jmcare/screens/detailslide/view.dart';
import 'package:jmcare/screens/historipoin/view.dart';
import 'package:jmcare/screens/home/view.dart';
import 'package:jmcare/screens/listcabang/view.dart';
import 'package:jmcare/screens/login/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/paginationuser/view.dart';
import 'package:jmcare/screens/pilihkontrak/view.dart';
import 'package:jmcare/screens/pilihregister/view.dart';
import 'package:jmcare/screens/pin/auth/view.dart';
import 'package:jmcare/screens/pin/register/view.dart';
import 'package:jmcare/screens/register/debitur/view.dart';
import 'package:jmcare/screens/register/nondebitur/view.dart';
import 'package:jmcare/screens/resetpassword/ceknomorhp/view.dart';
import 'package:jmcare/screens/resetpassword/passwordbaru/view.dart';
import 'package:jmcare/screens/resetpassword/pilihmetode/view.dart';
import 'package:jmcare/screens/resetpassword/verifikasiotp/view.dart';
import 'package:jmcare/screens/resetpassword/webview/view.dart';
import 'package:jmcare/screens/searchuser/view.dart';
import 'package:jmcare/screens/splash/view.dart';
import 'package:jmcare/screens/welcome/view.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


void main() {
  HttpOverrides.global = DioOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/bg_login.png"), context);
    // WidgetsFlutterBinding.ensureInitialized();
    final client = Dio();
    client.interceptors.addAll(Endpoint.dioInterceptors);
    BaseService.initialize(client);
    Service.setup(client);

    return GetMaterialApp(
      getPages: [
        GetPage(name: Konstan.rute_splash, page: () => const SplashScreen()),
        GetPage(name: Konstan.rute_login, page: () => const LoginScreen()),
        GetPage(name: Konstan.rute_home, page: () => const HomeScreen()),
        GetPage(name: Konstan.rute_pilih_register, page: () => const PilihRegisterScreen() ),
        GetPage(name: Konstan.rute_register_nondebitur, page: () => const RegisterNonDebiturScreen()),
        GetPage(name: Konstan.rute_register_debitur, page: () => const RegisterDebiturScreen()),
        GetPage(name: Konstan.rute_cek_nomor_hp, page: () => const CeknomorhpScreen()),
        GetPage(name: Konstan.rute_pilih_metode_reset_password, page: () => const PilihMetodeResetPasswordScreen()),
        GetPage(name: Konstan.rute_reset_password_webview, page: () => const ResetPasswordWebView()),
        GetPage(name: Konstan.rute_verifikasi_otp, page: () => const VerifikasiotpScreen()),
        GetPage(name: Konstan.rute_password_baru, page: () => const PasswordbaruScreen()),
        GetPage(name: Konstan.rute_detail_slide, page: () => const DetailslideScreen()),
        GetPage(name: Konstan.rute_welcome, page: () => const WelcomeScreen()),
        GetPage(name: Konstan.rute_histori_poin, page: () => const HistoripoinScreen()),
        GetPage(name: Konstan.rute_pagination_user, page: () => const PaginationuserScreen()),
        GetPage(name: Konstan.rute_search_user, page: () => const SearchuserScreen()),
        GetPage(name: Konstan.rute_list_cabang, page: () => const CabangScreen()),
        GetPage(name: Konstan.rute_register_pin, page: () => const RegisterpinScreen()),
        GetPage(name: Konstan.rute_auth_pin, page: () => const AuthpinScreen()),
        GetPage(name: Konstan.rute_pilih_no_kontrak, page: () => const PilihkontrakScreen()),
        GetPage(name: Konstan.rute_agreement_card, page: () => const AgreementcardScreen())
      ],
      title: 'JM CARE',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(),
    );
  }
}

class DioOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

