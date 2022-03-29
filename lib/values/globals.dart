import 'package:flutter_app/models/user/user_model.dart';
import 'package:get/get.dart';

/// Save information using in app
class Globals {
  static var userInfo = UserModel().obs; // User info
  static String language; // Language
  static String accessTokenAPI = ''; // Access token api
  static String firebaseToken = ''; // Firebase token
  static String deviceToken = ''; // Device token
  static Function onNavigationPush; // Push page function
  static Function onNavigationChange; // Navigation change
}
