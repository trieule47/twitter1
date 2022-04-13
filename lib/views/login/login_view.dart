import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/controllers/login_controller.dart';
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/models/common/app_bar_model.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/values/fonts.dart';
import 'package:flutter_app/views/base/base_view.dart';
import 'package:flutter_app/widgets/button_widget.dart';
import 'package:flutter_app/widgets/hr_widget.dart';
import 'package:flutter_app/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class LoginView extends BaseView {
  final LoginController _loginController =
      Get.put(LoginController()); // login controller

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget renderAppBar({BuildContext context, AppBarModel appBarModel}) {
    return super.renderAppBar(
      appBarModel: new AppBarModel(title: "Login", isBack: true),
    );
  }

  /// Render form text input
  Widget renderFormTextInput() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(Constants.padding16),
          child: Column(
            children: [
              TextFieldWidget(
                controller: _loginController.userNameTextController,
                labelText: Localizes.userName.tr,
                hintText: Localizes.userName.tr,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                margin: EdgeInsets.zero,
                containerDecoration: BoxDecoration(color: Colors.white),
              ),
              HrWidget(
                margin: EdgeInsets.only(
                    left: Constants.margin16, right: Constants.margin16),
              ),
              SizedBox(
                height: Constants.margin12 * 2,
              ),
              Obx(
                () => TextFieldWidget(
                  controller: _loginController.passwordTextController,
                  labelText: Localizes.password.tr,
                  hintText: Localizes.password.tr,
                  keyboardType: TextInputType.text,
                  obscureText: _loginController.hiddenPassword.value,
                  textInputAction: TextInputAction.next,
                  margin: EdgeInsets.zero,
                  containerDecoration: BoxDecoration(color: Colors.white),
                ),
              ),
              HrWidget(
                margin: EdgeInsets.only(
                    left: Constants.margin16, right: Constants.margin16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget renderButton() {
    return ButtonWidget(
      title: Localizes.signIn.tr,
      titleStyle: TextStyle(
        color: Colors.white,
        fontSize: Fonts.fontSizeMedium,
      ),
      margin: EdgeInsets.symmetric(
          vertical: Constants.margin16, horizontal: Constants.margin12),
      onTap: () {
        _loginController.login();
      },
    );
  }

  @override
  Widget renderBody() {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    renderFormTextInput(),
                    renderButton(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
