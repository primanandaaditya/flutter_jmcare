import 'package:dio/dio.dart';
import 'package:jmcare/service/CeknomorhpService.dart';
import 'package:jmcare/service/RegisterDebiturService.dart';
import 'package:jmcare/service/RegisterNonDebiturService.dart';
import 'BaseService.dart';
import 'LoginService.dart';

class Service {
  Dio? client;
  static late Service instance;

  Service();

  Service.setup(this.client) {
    instance = this;
  }

  Map<Type, BaseService> get classes {
    return {
      LoginService: LoginService.instance,
      RegisterDebiturService: RegisterDebiturService.instance,
      RegisterNonDebiturService: RegisterNonDebiturService.instance,
      CeknomorhpService: CeknomorhpService.instance
    };
  }

  static T? resolve<T extends BaseService?>() {
    if (instance.classes[T] == null) {
      throw "$T tidak diregistrasi. Periksa service!";
    }
    return instance.classes[T] as T?;
  }
}

T? getService<T extends BaseService>() {
  return Service.resolve<T>();
}
