import 'dart:convert';
import 'dart:io';
import 'package:device_id/device_id.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/configs/error_code.dart';
import 'package:flutter_app/enums/language_code.dart';
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/models/user/user_model.dart';
import 'package:flutter_app/repositories/user_repository.dart';
import 'package:flutter_app/router/router_config.dart';
import 'package:flutter_app/utils/storage_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/values/globals.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class BaseController extends GetxController {
  final chopperLogger = Logger(''); // Chopper logger
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final UserRepository _userRepository = UserRepository.getInstance();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var bytes = null.obs;
  bool isShowDialogSession = true;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _firebaseMessaging.unsubscribeFromTopic(Constants.topicNotification);
  }

  /// Handle net work error
  handleNetWorkError(Object obj) {
    this.closeLoading();
    chopperLogger.info(obj);
    if (obj is SocketException) {
      // OSError osError = obj.osError;
      // handleError(osError.errorCode);
      Utils.isNetWorkConnect().then((internet) => {
            if (internet != null && internet)
              {handleError(ErrorCode.common)}
            else
              {
                this.showMessage(
                  title: Localizes.notification.tr,
                  message: Localizes.connectServerErr.tr,
                )
              }
          });
    } else {
      handleError(ErrorCode.common);
    }
  }

  /// Handle error
  handleError(int errorCode, {String message}) {
    switch (errorCode) {
      default:
        this.showMessage(
          title: Localizes.notification.tr,
          message: Localizes.processingErr.tr,
        );
        break;
    }
  }

  /// Navigate to new screen with name.
  Future goTo(String router, [dynamic params]) async {
    this.navigatorPopOverlay();
    await Get.toNamed(router, arguments: params);
  }

  /// Navigate to new screen with name and bottom bar
  Future goToWithBottomBar(BuildContext context, String routerName) async {
    // await Get.toNamed(router, arguments: params);
    Globals.onNavigationPush(context, routerName);
  }

  /// Navigate and remove the previous screen from the tree.
  Future goToAndRemove(String router, [dynamic params]) async =>
      await Get.offNamed(router, arguments: params);

  /// Navigate and remove all previous screens from the tree.
  Future goToAndRemoveAll(String router, [dynamic params]) async =>
      await Get.offAllNamed(router, arguments: params);

  /// Go back
  Future goBack({BuildContext context, result}) async {
    this.navigatorPopOverlay();
    if (!Utils.isNull(context)) {
      Navigator.pop(context);
    } else {
      Get.back(result: result);
    }
  }

  /// Handle back
  Future<bool> handleBack() async {
    if (EasyLoading.isShow) {
      this.closeLoading();
    }
    return true;
  }

  /// Show dialog loading
  void showLoading() => EasyLoading.show();

  /// Close dialog loading
  void closeLoading() => EasyLoading.dismiss();

  /// Close snack bars, dialogs, bottom sheets, or anything you would normally
  void navigatorPopOverlay() {
    if (Get.isOverlaysOpen) Navigator.pop(Get.overlayContext);
  }

  /// Show message
  showMessage({String title, String message}) {
    if (!Get.isOverlaysOpen)
      Get.snackbar(
        title ?? Localizes.notification.tr,
        message,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(Constants.margin16),
      );
  }

  /// Handle message push
  static Future<dynamic> backgroundMessageHandler(
      Map<String, dynamic> message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotification =
        new FlutterLocalNotificationsPlugin();
    var initializationAndroid =
        new AndroidInitializationSettings('@mipmap/ic_notification');
    var initializationIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationAndroid, iOS: initializationIOS);
    flutterLocalNotification.initialize(initializationSettings);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'chanelId', 'channelName', 'channel description',
        importance: Importance.max,
        playSound: true,
        showProgress: true,
        priority: Priority.high,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await flutterLocalNotification.show(
      0,
      message['data']['title'],
      message['data']['body'],
      platformChannelSpecifics,
      payload: message['data'].toString(),
    );
    return Future<void>.value();
  }

  /// Show notification
  void showNotification({String title, String body, String data}) async {
    await _localNotification(title, body, data);
  }

  Future<void> _localNotification(
      String title, String body, String data) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'chanelId', 'channelName', 'channel description',
        importance: Importance.max,
        playSound: true,
        showProgress: true,
        priority: Priority.high,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: data);
  }

  /// Init handle notification
  handleNotification() async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_notification');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    _firebaseMessaging.subscribeToTopic(Constants.topicNotification);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        try {
          String title = "";
          String body = "";
          String type = "";
          dynamic data;
          String senderId = "";
          if (Platform.isIOS) {
            title = message['title'];
            body = message['body'];
            data = jsonEncode(message);
            type = message['type'];
            senderId = message['senderId'];
          } else {
            title = message['data']['title'];
            body = message['data']['body'];
            type = message['data']['type'];
            data = jsonEncode(message['data']);
            senderId = message['data']['senderId'];
          }
          showNotification(title: title, body: body, data: data);
          // this.countUnseenNotification();
          print("onMessage: $message");
        } on Exception catch (exception) {
          print(exception);
        }
      },
      onBackgroundMessage: backgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        String data =
            Platform.isIOS ? jsonEncode(message) : jsonEncode(message['data']);
        selectNotification(data);
      },
      onResume: (Map<String, dynamic> message) async {
        String data =
            Platform.isIOS ? jsonEncode(message) : jsonEncode(message['data']);
        selectNotification(data);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {});
  }

  /// on press notification
  Future selectNotification(String payload) async {
    Map<String, dynamic> data = jsonDecode(payload);
  }

  /// Get device token
  Future<String> getDeviceToken() async {
    try {
      String deviceId = await DeviceId.getID;
      Globals.deviceToken = deviceId;
      await StorageUtil.storeItem(StorageUtil.deviceToken, deviceId);
      return deviceId;
    } on PlatformException {
      print('Failed to get platform version');
    } on MissingPluginException {
      print('Get device token error');
    }
    return null;
  }

  /// Get token firebase
  Future<String> getFirebaseToken() async {
    var token = await _firebaseMessaging.getToken();
    Globals.firebaseToken = token;
    await StorageUtil.storeItem(StorageUtil.deviceToken, token);
    return token;
  }

  /// Log out
  Future<void> logout() async {
    this.showLoading();
    await StorageUtil.deleteItem(StorageUtil.userProfile);
    await StorageUtil.deleteItem(StorageUtil.firebaseToken);
    Globals.userInfo.value = UserModel();
    Globals.firebaseToken = '';
    this.closeLoading();
    this.goToAndRemoveAll(RouterConfig.ROUTE_LOGIN);
    Future.delayed(Duration(milliseconds: 2000), () {
      this.isShowDialogSession = true;
    });
  }

  /// Get language app
  Future<String> getLanguage() async {
    var data = await StorageUtil.retrieveItem(StorageUtil.language);
    if (!Utils.isNull(data)) {
      Globals.language = data as String;
      return Globals.language;
    } else {
      Globals.language = LanguageCode.VI;
      await StorageUtil.storeItem(StorageUtil.language, LanguageCode.VI);
      return LanguageCode.VI;
    }
  }

  /// Close keyboard
  void closeKeyboard() {
    FocusScope.of(Get.context).requestFocus(FocusNode());
  }
}
