import 'dart:async';
import 'dart:convert';
import 'package:jmcare/model/generator/ModelGenerator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

class BaseStorage<T> {
  T? data;
  final String? identifier;
  final StreamController<T?>? streamController;
  SharedPreferences prefs;
  BaseStorage<T> setData(T? value) {
    data = value;
    streamController!.add(data);
    return this;
  }

  T? getData() => data;
  final String? path;
  get stream => streamController!.stream;
  String storageKey() {
    return T.toString();
  }

  BaseStorage({this.streamController, this.identifier, this.path, required this.prefs});

  static Future<BaseStorage<S>> resolve<S>() async {
    final prefs = await SharedPreferences.getInstance();
    if (UniversalPlatform.isWeb) {
      final resolved = BaseStorage(
          streamController: StreamController<S>.broadcast(),
          identifier: DateTime.now().toIso8601String(), prefs: prefs);
      await resolved.load();
      return resolved;
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final resolved = BaseStorage(
          streamController: StreamController<S>.broadcast(),
          identifier: DateTime.now().toIso8601String(),
          prefs: prefs,
          path: '${directory.path}/storage/${S.toString()}.json');
      await resolved.load();
      return resolved;
    }
  }

  save() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(storageKey(), jsonEncode(data));
  }

  load() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataString = await prefs.getString(storageKey());
      if(dataString == null) return;
      final response = jsonDecode(dataString);
      setData(response == null ? response :  ModelGenerator.resolve<T>(response));
  }

  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
