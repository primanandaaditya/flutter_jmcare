import 'dart:convert';

import 'package:jmcare/model/api/AgreementcardRespon.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/CabangRespon.dart';
import 'package:jmcare/model/api/DownloadRespon.dart';
import 'package:jmcare/model/api/EpolisRespon.dart';
import 'package:jmcare/model/api/GradeRespon.dart';
import 'package:jmcare/model/api/HistoripoinRespon.dart';
import 'package:jmcare/model/api/KategoriRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/OtpModel.dart';
import 'package:jmcare/model/api/PaginationuserRespon.dart';
import 'package:jmcare/model/api/PertanyaanRespon.dart';
import 'package:jmcare/model/api/PilihkontrakRespon.dart';
import 'package:jmcare/model/api/ProdukRespon.dart';
import 'package:jmcare/model/api/PromoRespon.dart';
import 'package:jmcare/model/api/RiwayatantrianRespon.dart';
import 'package:jmcare/model/api/SlideshowRespon.dart';
import 'package:jmcare/model/session/RegisterpinModel.dart';
import 'package:jmcare/model/session/ResetPassModel.dart';
import 'package:jmcare/model/session/SelectedMethod.dart';
import 'package:jmcare/model/api/SmsRespon.dart';
import 'package:jmcare/model/session/ShowWelcome.dart';
import '../api/VersiRespon.dart';

class ModelGenerator {
  static ModelGenerator instance = ModelGenerator();
  get classes {
    return {
      LoginRespon : (json) => LoginRespon.fromJson(json),
      BaseRespon : (json) => BaseRespon.fromJson(json),
      ResetPassModel: (json) => ResetPassModel.fromJson(json),
      SelectedMethod: (json) => SelectedMethod.fromJson(json),
      SmsRespon: (json) => SmsRespon.fromJson(json),
      OtpModel: (json) => OtpModel.fromJson(json),
      VersiRespon: (json) => VersiRespon.fromJson(json),
      SlideshowRespon: (json) => SlideshowRespon.fromJson(json),
      ProdukRespon: (json) => ProdukRespon.fromJson(json),
      PromoRespon: (json) => PromoRespon.fromJson(json),
      ShowWelcome: (json) => ShowWelcome.fromJson(json),
      GradeRespon: (json) => GradeRespon.fromJson(json),
      HistoripoinRespon : (json) => HistoripoinRespon.fromJson(json),
      PaginationuserRespon : (json) => PaginationuserRespon.fromJson(json),
      CabangRespon : (json) => CabangRespon.fromJson(json),
      RegisterpinModel: (json) => RegisterpinModel.fromJson(json),
      PilihkontrakRespon: (json) => PilihkontrakRespon.fromJson(json),
      AgreementcardRespon: (json) => AgreementcardRespon.fromJson(json),
      EpolisRespon: (json) => EpolisRespon.fromJson(json),
      DownloadRespon: (json) => DownloadRespon.fromJson(json),
      KategoriRespon: (json) => KategoriRespon.fromJson(json),
      RiwayatantrianRespon: (json) => RiwayatantrianRespon.fromJson(json),
      PertanyaanRespon: (json) => PertanyaanRespon.fromJson(json)
    };
  }

  static T? resolve<T>(Map<String, dynamic>? json) {
    if (instance.classes[T] == null) {
      throw "Tipe $T tidak ditemukan. Pastikan sudah diregister di generator";
    }
    return instance.classes[T](json);
  }

}
