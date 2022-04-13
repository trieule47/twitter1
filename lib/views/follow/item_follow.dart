import 'dart:async';

import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/models/follower/follower_model.dart';
import 'package:flutter_app/views/base/base_view.dart';
import 'package:get/get.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/controllers/follow_controller.dart';

class ItemFollow extends BaseView {
  // List<FollowerModel> lists = List<FollowerModel>();
  //data['FollowerModel','List<FollowerModel>'
  List<dynamic> data;

  ItemFollow({this.data});

  final FollowController _followController = Get.put(FollowController());
  Timer _timer;
  void set(id) {
    _timer = new Timer.periodic(Duration(seconds: 20), (Timer timer) async {
      debugPrint("het 20 s");
      _followController.NewFollows(data[1].id, data[3]);
      //lists = _followController.listFollow;
      //ShowListNewFollow(_followController.newFollows.value.data);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: renderAppBar(),
      body: renderBody(),
    );
  }

  Widget renderBody() {
    return Column(
        children: [
          IconButton(onPressed: () {
            _followController.NewFollows('1445088239556067329',data[3]);///(id,index)
            //_followController.NewFollows(1445088239556067329);
            //set(1445088239556067329);
          }, icon: Icon(Icons.download)),
          IconButton(onPressed: () { _timer.cancel(); }, icon: Icon(Icons.delete)),
          //list of user
          Text('Name: ${data[1].name}'),
          ListUser(data[0]),
          //Obx(() =>ListUser(_followController.dataFollow)),
        ]
    );
  }

  ///list user follow
  Widget ListUser(users){
    var l;
    if(users==null) l=0; else l= users.length;
    return  Expanded(
      child: ListView.builder(
        itemCount: l,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTB25lYJUAyBrGFKHqg0c4g8atFIQPoIJdXcQ&usqp=CAU"),
                  radius: 40,
                ),
                onTap: (){
                },
                title: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text('${users[index].name}')),
                  ],
                ),
                subtitle: Text(users[index].username),
              ),
            ),
          );
        },
      ),
    );
  }
}

