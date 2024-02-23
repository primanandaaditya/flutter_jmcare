import 'dart:convert';

import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/OtpModel.dart';
import 'package:jmcare/model/session/ResetPassModel.dart';
import 'package:jmcare/model/session/SelectedMethod.dart';
import 'package:jmcare/model/api/SmsRespon.dart';

class ModelGenerator {
  static ModelGenerator instance = ModelGenerator();
  get classes {
    return {
      LoginRespon : (json) => LoginRespon.fromJson(json),
      BaseRespon : (json) => BaseRespon.fromJson(json),
      ResetPassModel: (json) => ResetPassModel.fromJson(json),
      SelectedMethod: (json) => SelectedMethod.fromJson(json),
      SmsRespon: (json) => SmsRespon.fromJson(json),
      OtpModel: (json) => OtpModel.fromJson(json)
    };
  }

  static T? resolve<T>(Map<String, dynamic>? json) {
    if (instance.classes[T] == null) {
      throw "Tipe $T tidak ditemukan. Pastikan sudah diregister di generator";
    }
    return instance.classes[T](json);
  }
}