import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/home_controller.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/views/base/base_view.dart';
import 'package:get/get.dart';

class HomeView extends BaseView {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget renderBody() {
    return Scaffold(
        // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
        body: Container(
          child: Center(
            child: Obx(
              () => Text(
                "Hello, home view: " + _homeController.count.value.toString(),
                style: CommonStyle.textLargeBold(),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: _homeController.increment));
  }
}
