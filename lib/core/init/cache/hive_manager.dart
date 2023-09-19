import '../../constants/hive_keys.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

import '../../hive_models/hive_user.dart';

class HiveManager {
  static final HiveManager _instance = HiveManager._init();

  static late List<Box<dynamic>> _db;

  static HiveManager get instance => _instance;

  HiveManager._init() {
    _db = [Hive.box("user-info"), Hive.box("user")];

    //openBox();
  }
  static preferencesInit() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();

    // Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    // Hive.init(directory.path);
    await Hive.initFlutter();
    //  HiveManager._init();

    Hive
      ..init(appDocumentDir.path)
      // ..registerAdapter(CurrencyTypeAdapter())
      // ..registerAdapter(LanguageTypeAdapter())
      ..registerAdapter(HiveUserObjectAdapter());

    await openBox();
    return;
  }

  static Future<void> openBox() async {
    _db = [await Hive.openBox("user-info"), await Hive.openBox("user")];
  }

  Future<void> setStringValue(HiveKeys key, String value) async {
    await _db[0].put(key.toString(), value);
  }

  String? getStringValue(HiveKeys key) => _db[0].get(key.toString());

  Future<void> setIntValue(HiveKeys key, int value) async {
    await _db[0].put(key.toString(), value);
  }

  int? getIntValue(HiveKeys key) => _db[0].get(key.toString());

  Future<void> setBoolValue(HiveKeys key, bool value) async {
    await _db[0].put(key.toString(), value);
  }

  bool? getBoolValue(HiveKeys key) => _db[0].get(key.toString());

  Iterable<dynamic> getAllValues() {
    return _db[0].values;
  }

  /* Future<void> setGenericValue<T>(HiveKeys key, T value) async {
    await _db[0].put(key.toString(), value);
  }*/

  // T? getGenericValue<T>(HiveKeys key) => _db[0].get(key.toString());

  /*Future<void> setUser(HiveUserObject user) async {
    await _db[1].add(user);
  }

  bool isDbEmpty() {
    return _db[1].isEmpty;
  }

  Future<void> updateUser(HiveUserObject user, int index) async {
    await _db[1].putAt(index, user);
  }*/

  Future<void> setUser(HiveUserObject user) async {
    await _db[1].put(HiveKeys.USER.toString(), user);
  }

  // HiveUserObject? getUser(int index) => _db[1].get(index);

  HiveUserObject? getUser() => _db[1].get(HiveKeys.USER.toString());

  Iterable<dynamic> getAllUsers() {
    return _db[1].values;
  }

  int? getUserIndex(HiveUserObject user) =>
      _db[1].values.toList().indexOf(user);

  //Future<void> deleteUser(int index) async => await _db[1].deleteAt(index);

  Future<void> deleteUser() async =>
      await _db[1].delete(HiveKeys.USER.toString());

  /*Future<void> deleteUsers() async {
    for (var element in _db[1].values) {
      await _db[1].deleteAt(_db[1].values.toList().indexOf(element));
    }
  }*/

  void clear() {
    _db.clear();
  }
}
