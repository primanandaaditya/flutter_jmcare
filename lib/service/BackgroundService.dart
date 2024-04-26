import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/service/NotifikasiService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundService {


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

    if (await Permission.notification.request().isGranted && await Permission.scheduleExactAlarm.request().isGranted){
      final service = FlutterBackgroundService();

      /// OPTIONAL, using custom notification channel id
      // const AndroidNotificationChannel channel = AndroidNotificationChannel(
      //   'my_foreground', // id
      //   'MY FOREGROUND SERVICE', // title
      //   description:
      //   'This channel is used for important notifications.', // description
      //   importance: Importance.low, // importance must be at low or higher level
      // );
      //
      // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      // FlutterLocalNotificationsPlugin();

      if (Platform.isIOS || Platform.isAndroid) {
        // await flutterLocalNotificationsPlugin.initialize(
        //   const InitializationSettings(
        //     iOS: DarwinInitializationSettings(),
        //     android: AndroidInitializationSettings('ic_bg_service_small'),
        //   ),
        // );
      }
      //
      // await flutterLocalNotificationsPlugin
      //     .resolvePlatformSpecificImplementation<
      //     AndroidFlutterLocalNotificationsPlugin>()
      //     ?.createNotificationChannel(channel);

      await service.configure(
        androidConfiguration: AndroidConfiguration(
          // this will be executed when app is in foreground or background in separated isolate
          onStart: onStart,

          // auto start service
          autoStart: true,
          isForegroundMode: true,

          // notificationChannelId: 'my_foreground',
          // initialNotificationTitle: 'AWESOME SERVICE',
          // initialNotificationContent: 'Initializing',
          // foregroundServiceNotificationId: 888,
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
    // For flutter prior to version 3.0.0
    // We have to register the plugin manually


    /// OPTIONAL when use custom notification
    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    // FlutterLocalNotificationsPlugin();

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
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {

          //cek api get kusioner
          //cek dulu apakah sudah login atau belum
          final authStorage = await getStorage<LoginRespon>();
          if(authStorage.data!.loginUserId != null){
            //berarti sdh login
            //hit api get kuisioner
            final userID = authStorage.data!.loginUserId;
            final respon = await getService<NotifikasiService>()?.getNotifikasi(userID!, "0");
            if (respon!.data!.isEmpty){

            }else{
              //jika ada antrian yang belum isi kuisioner
              //munculkan notifikasi
              Get.defaultDialog(title: "Kuisioner tersedia!");
            }
          }else{
            //belum login
          }

          /// OPTIONAL for use custom notification
          /// the notification id must be equals with AndroidConfiguration when you call configure() method.
          // flutterLocalNotificationsPlugin.show(
          //   888,
          //   'COOL SERVICE',
          //   'Awesome ${DateTime.now()}',
          //   const NotificationDetails(
          //     android: AndroidNotificationDetails(
          //       'my_foreground',
          //       'MY FOREGROUND SERVICE',
          //       icon: 'ic_bg_service_small',
          //       ongoing: true,
          //     ),
          //   ),
          // );
          print("Halo");

          // if you don't using custom notification, uncomment this
          service.setForegroundNotificationInfo(
            title: "My App Service",
            content: "Updated at ${DateTime.now()}",
          );
        }
      }
      /// you can see this log in logcat
      print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
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

}