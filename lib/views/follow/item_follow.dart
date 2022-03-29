import 'package:flutter/material.dart' hide Colors;
import 'package:get/get.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/controllers/follow_controller.dart';

class ItemFollow extends StatelessWidget {

  final FollowController _followController = Get.put(FollowController());

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
          //list of user
          Obx(() => ListUser(_followController.listFollow.value.data)),
        ]
    );
  }

  //list user follow
  Widget ListUser(users){
    return  Expanded(
      child: ListView.builder(
        itemCount: users.length ,
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
                        child: Text('${users[index].id}', )),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(top:10, bottom:10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.black,
                          ),

                          child:  FlatButton(
                            child: Text('Đang theo dõi', style: TextStyle(fontSize: 13, color: Colors.white, backgroundColor: Colors.black  ), ),
                            onPressed: ((){

                            }),
                          )
                      ),
                    )
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

