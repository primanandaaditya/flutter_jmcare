import 'dart:convert';

import 'package:jmcare/model/BaseRespon.dart';
import 'package:jmcare/model/LoginRespon.dart';
import 'package:jmcare/model/OtpModel.dart';
import 'package:jmcare/model/ResetPassModel.dart';
import 'package:jmcare/model/SelectedMethod.dart';
import 'package:jmcare/model/SmsRespon.dart';

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
