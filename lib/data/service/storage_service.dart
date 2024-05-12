import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._();

  static final _instance = StorageService._();
  static late final SharedPreferences _mPref;

  /// keys
  static const isFirstUseKey = "firstUse";

  factory StorageService() {
    _createShared();
    return _instance;
  }

  static void _createShared() async {
    _mPref = await SharedPreferences.getInstance();
  }

  Future<bool> setFirstUse() {
    return _mPref.setBool(isFirstUseKey, true);
  }

  bool isFirstUse() => _mPref.getBool(isFirstUseKey) ?? false;
}
