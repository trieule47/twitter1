import 'dart:async';

import 'package:chopper/chopper.dart' hide Get;
import 'package:flutter/material.dart';
import 'package:flutter_app/models/common/app_bar_model.dart';
import 'package:flutter_app/models/follow/follow_model.dart';
import 'package:flutter_app/router/router_config.dart';
import 'package:flutter_app/utils/storage_util.dart';
import 'package:flutter_app/views/base/base_view.dart';
import 'package:flutter_app/controllers/follow_controller.dart';
import 'package:flutter_app/views/follow/item_follow.dart';
import 'package:flutter_app/widgets/search_widget.dart';
import 'package:flutter_app/widgets/text_field_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class FollowView extends BaseView {
  final FollowController _followController = Get.put(FollowController());
  int search = 1445088239556067329;
  Timer _timer;

  @override

  ///after 30s auto request follow list to check star
  void SetInterval() {
    _timer = Timer.periodic(Duration(seconds: 180), (Timer timer) async {
      debugPrint("start fetch");
      _followController.newAllListFollow();
    });
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  String username = '';

  @override
  Widget renderAppBar({BuildContext context, AppBarModel appBarModel}) {
    return super.renderAppBar(
      context: context,
      appBarModel: new AppBarModel(
        isBackground: false,
        titleWidget: Text("Watch follower"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              print(context);
              final String result = await showSearch(
                  context: context,
                  delegate: Search(Suggestions: _followController.Suggestions));
              username = result.trim();
              if (username != '') {
                _followController.setSuggestion(username);
                _followController.getUserByUsername(username);
                print('username : $username');
                SetInterval();
              }
            },
          )
        ],
      ),
    );
  }

  @override
  Widget renderBody() {
    print(_followController.ListUsers.length);
    return Obx(
            () =>Scaffold(
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: _followController.ListUsers.length,
          itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 60,
            color: Colors.amberAccent,
            child: Row(
              children: [
                Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    //  color: Colors.blue,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: FlatButton(
                        onPressed: () {
                          print('deleted all user $index');
                          _followController.removeItem(index);
                          print(_followController.ListUsers.toString());
                        },
                        child: Text("X",
                            style:
                                TextStyle(color: Colors.red, fontSize: 16)))),
                Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    //  color: Colors.blue,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: FlatButton(
                        onPressed: () {
                          print('Watch user $index');
                          _followController.NewFollows(_followController.ListUsers[index].id, index);
                        },
                        child: Text("W",
                            style:
                            TextStyle(color: Colors.green, fontSize: 16)))),
                Expanded(
                  child: FlatButton(
                      onPressed: () async {
                        print("Click this is add new user");
                        try {
                          _followController.allListFollows =
                              await _followController.getListFollow();
                          print('Click button add');
                          _followController
                              .goTo(RouterConfig.ROUTE_DETAIL_FOLLOW, [
                            _followController.allListFollows[index][1],
                            _followController.ListUsers[index],
                            'List Follow',
                            index,
                          ]);
                        } catch (err) {
                          print('Caught error: $err');
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            '${_followController.ListUsers[index].name}',
                            style: TextStyle(color: Colors.black),
                          ))),
                ),
                Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    //  color: Colors.blue,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: FlatButton(
                      child: Obx(() => Text(
                          "${_followController.allListDataFollow[index].length}",
                          style: TextStyle(color: Colors.blue, fontSize: 16))),
                      onPressed: () {
                        if (!_followController.allListDataFollow[index].isEmpty)
                          _followController.goTo(
                              RouterConfig.ROUTE_DETAIL_FOLLOW, [
                            _followController.allListDataFollow[index],
                            _followController.ListUsers[index],
                            'New Follow'
                          ]);
                      },
                    )),
                Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    //  color: Colors.blue,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: FlatButton(
                      child: Obx(() => Text(
                          "${_followController.allListDataUnFollow[index].length}",
                          style: TextStyle(color: Colors.red, fontSize: 16))),
                      onPressed: () {
                        if (!_followController.allListDataUnFollow[index].isEmpty)
                          _followController.goTo(
                              RouterConfig.ROUTE_DETAIL_FOLLOW, [
                            _followController.allListDataUnFollow[index],
                            _followController.ListUsers[index],
                            'Unfollow'
                          ]);
                      },
                    )),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    ));
  }

  // return Scaffold(
  //   body: Container(
  //     child: Center(
  //       child: Column(
  //         children: [
  //           Text("data", style: TextStyle(color: Colors.blue),),
  //           ListView.builder(
  //             itemCount: 4,
  //             itemBuilder: (context, position) {
  //               return Text("data", style: TextStyle(color: Colors.blue),);
  //             },
  //           ),
  //
  //           // Container(
  //           //   margin: const EdgeInsets.only(top:40),
  //           //   padding: const EdgeInsets.all(9),
  //           //   child: IconButton(onPressed: (){
  //           //     _timer.cancel();
  //           //   },
  //           //       icon: Icon(Icons.add)
  //           //   ),
  //           // ),
  //
  //           // TextField(
  //           //   controller: _followController.searchTextController,
  //           //   onChanged: (text){
  //           //         () {
  //           //       search = int.parse(text);//when state changed=> build rerun => reload widget
  //           //       set();
  //           //     };
  //           //   },
  //           //   decoration: InputDecoration(
  //           //       border: OutlineInputBorder(
  //           //         borderRadius: const BorderRadius.all(
  //           //             const Radius.circular(30)
  //           //         ),
  //           //       ),
  //           //       labelText: 'Enter your id'
  //           //   ),
  //           // ),
  //           // IconButton(onPressed: () {}, icon: Icon(Icons.add)),
  //
  //
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               FlatButton(
  //                   child: Text('Watcher',style: TextStyle(fontSize: 14),),
  //                   onPressed: (){
  //                     set();
  //                     _followController.NewFollowList(search);
  //                     ShowListNewFollow(_followController.newFollows.value.data);
  //                   },
  //               ),
  //               FlatButton(
  //                 child: Text('cancel Watcher',style: TextStyle(fontSize: 14),),
  //                 onPressed: (){
  //                   _timer.cancel();
  //                 },
  //               ),
  //               IconButton(
  //                   onPressed: (){
  //                     _followController.GetFollowList(search);
  //                   },
  //                   icon: Icon(Icons.search)
  //               ),
  //               IconButton(onPressed: (){
  //                   _timer.cancel();
  //                   },
  //                   icon: Icon(Icons.cancel))
  //             ],
  //           ),
  //           // Expanded(
  //           // child:  ItemFollow(),
  //           // ),
  //         ],
  //       )
  //     )
  //   )
  //);
  //}
}
