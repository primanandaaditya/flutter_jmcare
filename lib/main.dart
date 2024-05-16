import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/NotifikasiRespon.dart';
import 'package:jmcare/model/api/SingleNotifikasiRespon.dart';
import 'package:jmcare/screens/agreementcard/view.dart';
import 'package:jmcare/screens/antrian/detailriwayat/view.dart';
import 'package:jmcare/screens/antrian/kuisioner/view.dart';
import 'package:jmcare/screens/antrian/view.dart';
import 'package:jmcare/screens/detailslide/view.dart';
import 'package:jmcare/screens/dialog/jmo/view.dart';
import 'package:jmcare/screens/dialog/list_cabang/view.dart';
import 'package:jmcare/screens/dialog/tujuan_kedatangan/view.dart';
import 'package:jmcare/screens/dialog/wilayah/view.dart';
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
import 'package:jmcare/screens/pengkiniandata/view.dart';
import 'package:jmcare/service/BackgroundService.dart';
import 'package:dio/dio.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/service/NotifikasiService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'model/api/LoginRespon.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = DioOverrides();
  await initializeService();
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
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top
    ]);

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
        GetPage(name: Konstan.rute_agreement_card, page: () => const AgreementcardScreen()),
        GetPage(name: Konstan.rute_antrian, page: () => const AntrianScreen()),
        GetPage(name: Konstan.rute_tujuan_kedatangan, page: () => const DialogTujuankedatangan()),
        GetPage(name: Konstan.rute_dialog_cabang, page: () => const DialogCabang()),
        GetPage(name: Konstan.rute_detail_riwayat_antrian, page: () => const DetailRiwayatAntrian()),
        GetPage(name: Konstan.rute_kuisioner, page: () => const KuisionerScreen()),
        GetPage(name: Konstan.rute_pengkinian_data, page: () => const PengkiniandataScreen()),
        GetPage(name: Konstan.rute_dialog_wilayah, page: () => const DialogWilayahScreen()),
        GetPage(name: Konstan.rute_dialog_jmo, page: () => const DialogjmoScreen())
      ],
      title: 'JM CARE',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SafeArea(
        child: SplashScreen(),
      ),
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

void askPermission() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.storage,
    Permission.notification,
    Permission.scheduleExactAlarm
  ].request();
}

Future<void> initializeService() async {

  askPermission();

  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_notifjmcare'),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse notificationresponse){
        Get.toNamed(Konstan.rute_kuisioner, arguments: {Konstan.tag_id_antrian: notificationresponse.payload} );
      }
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: false,
      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'JM CARE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,
      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,
      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();
  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // bring to foreground
  Timer.periodic(const Duration(seconds: 10), (timer) async {

    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    final storageAuth = await getStorage<LoginRespon>();
    if(storageAuth.data?.loginUserId != null){

      final userID = storageAuth.data!.loginUserId;
      final dio = Dio();
      dio.options.baseUrl = Endpoint.base_url;

      //cek jam sekarang
      //kalau 8-15 => waktu_notifikasi = 0, kalo tidak = 1
      DateTime skr = DateTime.now();
      final jam_skr = skr.hour;
      int waktu_notifikasi = ( jam_skr >= 8 && jam_skr <= 17 ) ? 0 : 1;
      final r = await dio.post(
          Endpoint.TAG_ANTRIAN_NOTIFIKASI_KUISIONER,
          data: jsonEncode({"id_user":userID,"waktu_notifikasi":waktu_notifikasi}),
          options: Options(
              headers: BaseService.headerPlain
          )
      );
      print("respon " + r.data.toString());

      //jika json respon tidak ada data, berarti tidak usah munculkan notif
      if (r.data.toString() == "[]"){
        print("Tidak ada data kuis");
      }else{
        print("Ada data kuis");
        /// OPTIONAL for use custom notification
        /// the notification id must be equals with AndroidConfiguration when you call configure() method.

        //konvert respon jadi object
        final hasil = (r.data as List).map((x) => SingleNotifikasiRespon.fromJson(x) ).toList();

        //sesudah dikonvert, get first arraynya
        final pertama = hasil.first;
        final id_antrian =  pertama.iD;

        flutterLocalNotificationsPlugin.show(
          888,
          'Antrian Online',
          'Isi survey untuk meningkatkan kualitas kerja kami',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              icon: 'ic_notifjmcare',
              ongoing: true,
            ),
          ),
          payload: id_antrian
        );
      }
    }else{
      print("Belum login");
    }

    // test using external plugin
    final deviceInfo = DeviceInfoPlugin();
    String? device;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
    }
    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
    }
    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
        "device": device,
      },
    );
  });
}