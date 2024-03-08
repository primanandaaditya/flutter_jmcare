import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:path_provider/path_provider.dart';
import '../model/api/models.dart' as models;

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

  //tambahkan '{"data":' di sebelah kiri respon dan '}' disebelah kanan respon
  //buat model di json to dart berdasarkan tambahan tadi
  Future<T?> getJsonArray<T>(String url, {Map<String, dynamic>? body}) async {
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
    var encoded = jsonEncode(response.data);
    var bodi = '{"data":'  + encoded + '}';
    var decoded = jsonDecode(bodi);
    return models.ModelGenerator.resolve<T>(decoded);
  }

  //tambahkan '{"data":' di sebelah kiri respon dan '}' disebelah kanan respon
  //buat model di json to dart berdasarkan tambahan tadi
  Future<T?> getResources<T>(String url, {Map<String, dynamic>? body}) async {
    String param = jsonEncode(body);
    client.options.baseUrl = Endpoint.base_url;
    final response = await _wrapRequest(() => client.post(url,
        data: param,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'merchantkey': Konstan.tag_merchant_key,
            'authorization': basicAuth
          },
        ))
    );
    var encoded = jsonEncode(response.data);
    var bodi = '{"data":'  + encoded + '}';
    var decoded = jsonDecode(bodi);
    return models.ModelGenerator.resolve<T>(decoded);
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

  Future<void> download(String baseURL, String fileName) async {
    client.options.baseUrl = baseURL;
    String path = await _getFilePath(fileName);
    await _wrapRequest(() => client.download(
        baseURL,
        path
    ));
  }

  Future<String> _getFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/');  // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      Fungsi.errorToast("Cannot get download folder path $err");
    }
    return "${dir?.path}$filename";
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

  //
  // makeRequest(String? url) async {
  //   Dio dio = Dio(BaseOptions(contentType: Headers.jsonContentType,responseType: ResponseType.json,validateStatus: (_)=>true,));
  //   Response facilityResponse = await dio.get(
  //       url!
  //   );
  //   print("woy ${facilityResponse}");
  // }
}
