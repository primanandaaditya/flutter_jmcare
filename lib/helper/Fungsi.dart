
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Fungsi{

  static toastBelumLogin(BuildContext context){
    showSnack(context, "Silakan login terlebih dahulu", "OK", 2);
  }

  static Future<void> cekFingerprint(BuildContext context) async {

    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (canAuthenticate){
      final List<BiometricType> availableBiometrics =
      await auth.getAvailableBiometrics();

      if (availableBiometrics.isNotEmpty) {
        debugPrint("available bio");
        try {
          final bool didAuthenticate = await auth.authenticate(
              localizedReason: 'Gunakan sidik jari sebagai alternatif PIN',
              options: const AuthenticationOptions(useErrorDialogs: false));
          if (didAuthenticate){
            Navigator.popAndPushNamed(context, '/home');
          }else{
            Fungsi.showSnack(context, "Silakan memasukkan PIN", "OK", 2);
          }
        } on PlatformException catch (e) {
          Fungsi.showSnack(context, e.message.toString(), "OK", 1);
        }
      }else{
        debugPrint("not available bio");
      }
    }
  }

  static logOut(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
  }

  static Future<bool?> dialogLogout(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: true, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Apakah Anda yakin akan logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),

          ],
        );
      },
    );
  }


  static String formatTanggal(String tanggalYYYYmmdd){
    try{
      var tgl = DateFormat("yyyy-MM-ddThh:mm:ss").parse(tanggalYYYYmmdd);
      var tgla = DateFormat('dd MMM yyyy hh:mm:ss').format(tgl);
      return tgla;
    }catch(e){
      var tgl = DateFormat("dd-MM-yyyy hh:mm:ss").parse(tanggalYYYYmmdd);
      var tgla = DateFormat('dd MMM yyyy hh:mm:ss').format(tgl);
      return tgla;
    }
  }

  static String formatNumber(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: '',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  static String thousandSeparator (int str) {
    var formatter = NumberFormat('##,##0');
    return formatter.format(str);
  }

  static showSnack(BuildContext context, String konten, String label, int durasiDetik ){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:  Text(konten),
      duration: Duration(seconds: durasiDetik ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      action: SnackBarAction(
        label: label,
        onPressed: () {

        },
      ),
    ));
  }
}