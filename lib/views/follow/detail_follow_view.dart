import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/follow_controller.dart';
import 'package:flutter_app/models/common/app_bar_model.dart';
import 'package:flutter_app/models/follower/follower_model.dart';
import 'package:flutter_app/views/base/base_view.dart';
import 'package:flutter_app/views/follow/item_follow.dart';
import 'package:get/get.dart';
class DetailFollow extends BaseView {
  //var arguments = List<FollowerModel>();

  dynamic arguments = Get.arguments;

  @override
  Widget renderAppBar({BuildContext context, AppBarModel appBarModel}) {
    print('args : id ${arguments[1].id} : array${arguments[0].toString()}');
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text("Detail ${arguments[2]}"),
      actions: [
        Row(
          children: [
            SizedBox(
              width: 16,
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget renderBody() {
    return Scaffold(
      body:
      //Text('hello'),
      ItemFollow(data: arguments),
    );
  }
}

