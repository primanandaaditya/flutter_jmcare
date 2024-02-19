import 'package:jmcare/model/BaseRespon.dart';
import 'package:jmcare/model/LoginRespon.dart';

class ModelGenerator {
  static ModelGenerator instance = ModelGenerator();
  get classes {
    return {
      LoginRespon : (json) => LoginRespon.fromJson(json),
      BaseRespon : (json) => BaseRespon.fromJson(json)
    };
  }

  static T? resolve<T>(Map<String, dynamic>? json) {
    if (instance.classes[T] == null) {
      throw "Tipe $T tidak ditemukan. Pastikan sudah diregister di generator";
    }
    return instance.classes[T](json);
  }
}
