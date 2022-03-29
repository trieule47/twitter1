import 'package:get/get.dart';

class Localizes {
  // Language code
  static const viCode = 'vi';
  static const enCode = 'en';

  // Key string
  static String signIn = "signIn";
  static String logout = "logout";
  static String password = "password";
  static String cancel = "cancel";
  static String confirm = "confirm";
  static String loading = "loading";
  static String notification = "notification";
  static String processingErr = "processingErr";
  static String connectServerErr = "connectServerErr";
  static String noData = "noData";
  static String userName = "userName";

  // Key string trArgs
  static String pleaseEnter(String value) => "signIn".trArgs([value]);
}
