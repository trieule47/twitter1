import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/values/globals.dart';
import 'package:get/get.dart';

import 'storage_util.dart';

class Utils {
  /// Checks if data is null.
  static bool isNull(dynamic data) {
    if (data is String && data.isEmpty) {
      return true;
    }
    return GetUtils.isNull(data);
  }

  /// Check have network connect
  static Future<bool> isNetWorkConnect() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  /// Get language app
  static Future<void> getLocaleLanguageApp() async {
    var data = await StorageUtil.retrieveItem(StorageUtil.language);
    if (!Utils.isNull(data)) {
      Globals.language = data as String;
    } else {
      Globals.language = Constants.langCountryEN;
    }
    List<String> values = Globals.language.split('_');
    if (values.length > 1) {
      return Get.updateLocale(Locale(values[0], values[1]));
    }
  }
}
