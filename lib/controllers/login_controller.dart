import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/base_controller.dart';
import 'package:flutter_app/models/user/user_model.dart';
import 'package:flutter_app/repositories/user_repository.dart';
import 'package:flutter_app/router/router_config.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  UserRepository _userRepository = UserRepository.getInstance();
  var userModel = UserModel().obs;
  TextEditingController passwordTextController;
  TextEditingController userNameTextController;
  var hiddenPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    userNameTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  /// Login
  void login() async {
    this.showLoading();
    Future.delayed(Duration(milliseconds: 1500), () {
      this.closeLoading();
      this.goToAndRemoveAll(RouterConfig.ROUTE_HOME);
    });

    // LoginFilter filter = LoginFilter("0789740506", "123123", "0789740p506");
    // await _userRepository.login(filter);
    // _userRepository.login(filter).then((it) {
    //   dynamic weatherResponse = it;
    //   userModel = UserModel.fromJson(weatherResponse.body.data).obs;
    //   if (weatherResponse.body.errorCode == 200) {
    //     Get.offNamed('/home');
    //   } else {
    //     handleError(weatherResponse.body.errorCode);
    //   }
    // }).catchError((Object obj) {
    //   handleNetWorkError(obj);
    // });
  }

  @override
  void onClose() {
    userNameTextController?.dispose();
    passwordTextController?.dispose();
    super.onClose();
  }
}
