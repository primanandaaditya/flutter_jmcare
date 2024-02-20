import 'dart:io';
import 'package:dio/dio.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/screens/home/view.dart';
import 'package:jmcare/screens/login/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/pilihregister/view.dart';
import 'package:jmcare/screens/register/debitur/view.dart';
import 'package:jmcare/screens/register/nondebitur/view.dart';
import 'package:jmcare/screens/splash/view.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/service/Service.dart';

void main() {
  HttpOverrides.global = DioOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // WidgetsFlutterBinding.ensureInitialized();
    final client = Dio();
    client.interceptors.addAll(Endpoint.dioInterceptors);
    BaseService.initialize(client);
    Service.setup(client);

    return GetMaterialApp(
      getPages: [
        GetPage(name: Konstan.rute_login, page: () => const LoginScreen()),
        GetPage(name: Konstan.rute_home, page: () => const HomeScreen()),
        GetPage(name: Konstan.rute_pilih_register, page: () => const PilihRegisterScreen() ),
        GetPage(name: Konstan.rute_register_nondebitur, page: () => const RegisterNonDebiturScreen()),
        GetPage(name: Konstan.rute_register_debitur, page: () => const RegisterDebiturScreen())
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