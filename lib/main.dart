import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/router/router_config.dart';
import 'package:flutter_app/utils/storage_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import 'locales/app_translations.dart';
import 'locales/localizes.dart';
import 'models/user/user_model.dart';
import 'styles/common_style.dart';
import 'utils/utils.dart';
import 'values/colors.dart';
import 'values/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  setupLogging();
  await checkStatusLogin();
  await Utils.getLocaleLanguageApp();
  runApp(MyApp());
  configLoading();
}

/// Check status login
Future<void> checkStatusLogin() async {
  String accessTokenAPI =
      await StorageUtil.retrieveItem(StorageUtil.accessTokenAPI);
  var user = await StorageUtil.retrieveItem(StorageUtil.userProfile);
  if (!Utils.isNull(accessTokenAPI) && !Utils.isNull(user)) {
    Globals.accessTokenAPI = accessTokenAPI;
    Globals.userInfo.value = UserModel.fromJson(user);
  }
}

/// Setup log
void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

/// Config loading
void configLoading() => EasyLoading.instance
  ..displayDuration = const Duration(milliseconds: 2000)
  ..indicatorType = EasyLoadingIndicatorType.ring
  ..loadingStyle = EasyLoadingStyle.custom
  ..indicatorSize = 40.0
  ..radius = 10.0
  ..progressColor = Colors.primary
  ..backgroundColor = Colors.transparent
  ..indicatorColor = Colors.primary
  ..textColor = Colors.primary
  ..maskColor = Colors.blue.withOpacity(0.5)
  ..userInteractions = false
  ..dismissOnTap = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kinder World',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      getPages: RouterConfig.route,
      // initialRoute: Utils.isNull(Globals.accessTokenAPI)
      //     ? RouterConfig.ROUTE_LOGIN
      //     : RouterConfig.ROUTE_MAIN,
      initialRoute: RouterConfig.ROUTE_FOLLOW,
      translations: AppTranslations(),
      theme: CommonStyle.mainTheme,
      builder: EasyLoading.init(),
      routingCallback: (routing) {
        if (routing.current == RouterConfig.ROUTE_MAIN) {}
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale(Localizes.enCode, ''),
        const Locale(Localizes.viCode, '')
      ],
    );
  }
}
