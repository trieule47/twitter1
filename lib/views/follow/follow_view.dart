import 'dart:async';

import 'package:chopper/chopper.dart' hide Get;
import 'package:flutter/material.dart';
import 'package:flutter_app/models/common/app_bar_model.dart';
import 'package:flutter_app/views/base/base_view.dart';
import 'package:flutter_app/controllers/follow_controller.dart';
import 'package:flutter_app/views/follow/item_follow.dart';
import 'package:flutter_app/widgets/text_field_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class FollowView extends BaseView{
  final FollowController _followController = Get.put(FollowController());
  int search = 1445088239556067329;
  Timer _timer;
  @override
  ///after 30s auto request follow list to check star
  void set() {
    _timer = Timer.periodic(Duration(seconds: 30), (Timer timer)async {
        debugPrint("het 10 s");
       _followController.NewFollowList(search);
       ShowListNewFollow(_followController.newFollows.value.data);
   });
  }

  @override
  Widget build(BuildContext context){
    return super.build(context);
  }

  @override
  Widget renderBody(){
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              // TextFieldWidget(
              //   controller: _followController.searchTextController,
              //   textAlign: TextAlign.center,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     border: InputBorder.none,
              //   ),
              // ),
              TextField(
                controller: _followController.searchTextController,
                onChanged: (text){
                  () {
                    search = int.parse(text);//when state changed=> build rerun => reload widget
                    set();
                  };
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                          const Radius.circular(30)
                      ),
                    ),
                    labelText: 'Enter your email'
                ),
              ),
              Row(
                children: [
                  FlatButton(
                      child: Text('Watcher',style: TextStyle(fontSize: 14),),
                      onPressed: (){
                        set();
                        _followController.NewFollowList(search);
                        ShowListNewFollow(_followController.newFollows.value.data);
                      },
                  ),
                  FlatButton(
                    child: Text('cancel Watcher',style: TextStyle(fontSize: 14),),
                    onPressed: (){
                      _timer.cancel();
                    },
                  ),
                  IconButton(
                      onPressed: (){
                        _followController.GetFollowList(search);
                      },
                      icon: Icon(Icons.search)
                  ),
                  IconButton(onPressed: (){
                      _timer.cancel();
                      },
                      icon: Icon(Icons.cancel))
                ],
              ),
              Expanded(
              child:  ItemFollow(),
              ),
            ],
          )
        )
      )
    );
  }
}
