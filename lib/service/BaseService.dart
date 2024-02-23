import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/generator/ModelGenerator.dart' as models;

class ServiceLoggerInterceptor extends InterceptorsWrapper {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
}

abstract class BaseService {

  String username = "saya#4dalahus3r*jmpmfi!";
  String password = "jmpmf!@2022*api=keren";
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('saya#4dalahus3r*jmpmfi!' + ':' + 'jmpmf!@2022*api=keren'));
  static late Dio client;

  static initialize(Dio newClient) async {
    client = newClient;
  }

  Future<T?> post<T>(String url, {Map<String, dynamic>? body}) async {
    final response = await _wrapRequest(() => client.post(url,
        data: body));
    return models.ModelGenerator.resolve<T>(response.data);
  }

  Future<T?> postJSON<T>(String url, {Map<String, dynamic>? body}) async {
    client.options.baseUrl = Endpoint.base_url;
    final response = await _wrapRequest(() => client.post(url,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'merchantkey': Konstan.tag_merchant_key,
            'authorization': basicAuth
          },
        ))
    );
    return models.ModelGenerator.resolve<T>(response.data);
  }

  Future<T?> postString<T>(String url, {Map<String, dynamic>? body}) async {
    String param = jsonEncode(body);
    client.options.baseUrl = Endpoint.base_url;
    final response = await _wrapRequest(() => client.post(url,
        data: param,
        options: Options(
          headers: {
            'Content-Type': 'text/plain',
            'Accept': '*/*',
            'merchantkey': Konstan.tag_merchant_key,
            'authorization': basicAuth
          },
        ))
    );
    return models.ModelGenerator.resolve<T>(response.data);
  }

  Future<T?> postSMS<T>(String url) async {
    client.options.baseUrl = Endpoint.base_url_reset_pass_sms;
    final response = await _wrapRequest(() => client.post(url,
        options: Options(
          headers: {
            'Accept': '*/*'
          },
        ))
    );
    return models.ModelGenerator.resolve<T>(response.data);
  }



  _wrapRequest(request, {int retryCount = 3}) async {
    try {
      return await request();
    } on DioError catch (e) {
      if (e.error is SocketException) {
        if (retryCount == 3) {
          rethrow;
        } else {
          await Future.delayed(const Duration(seconds: 1), () {
            print('retrying request');
          });
          return _wrapRequest(request, retryCount: retryCount + 1);
        }
      }
      rethrow;
    } on SocketException catch (e) {
      if (retryCount == 3) {
        rethrow;
      } else {
        await Future.delayed(const Duration(seconds: 1), () {
          print('retrying request');
        });
        return _wrapRequest(request, retryCount: retryCount + 1);
      }
    } catch (e) {
      rethrow;
    }
  }


  makeRequest(String? url) async {
    Dio dio = Dio(BaseOptions(contentType: Headers.jsonContentType,responseType: ResponseType.json,validateStatus: (_)=>true,));
    Response facilityResponse = await dio.get(
        url!
    );
    print("woy ${facilityResponse}");
  }
}
