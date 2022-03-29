import 'package:flutter_app/repositories/follow_repositories.dart';

import 'base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app/models/follow/follow_model.dart';

class FollowController extends BaseController{
  var listFollow = FollowModel().obs;
  var dataFollow = FollowModel().obs;
  var newFollows = FollowModel().obs;
  var idUser=1445088239556067329;
  TextEditingController searchTextController;

  final FollowRepository _followRepo =
      FollowRepository.getInstance();

 @override
  void onInit(){
    searchTextController = TextEditingController();
    this.showLoading();
    apiGetFollowList(1445088239556067329);
    super.onInit();
 }

 //search by id user
  void GetFollowList(id){
    this.showLoading();
    apiGetFollowList(id);
  }

 Future<void> apiGetFollowList(id) async {
  await _followRepo
      .getListFollow(id)
      .then((apiResponse){
      this.closeLoading();
        if(apiResponse.isSuccessful){
          var data = apiResponse.body.toJson();
          if(data != null) {
            FollowModel value = FollowModel.fromJson(data);
            this.listFollow.value = value;
          }
        }
      })
      .catchError((Object onError){
       handleNetWorkError(onError);
  });
 }
  //list new follow of user
  void NewFollowList(id) {
    this.showLoading();
    GetNewFollowList(id);
  }

  Future<void> GetNewFollowList(id) async {
    await _followRepo
        .getListFollow(id)
        .then((apiResponse){
      this.closeLoading();
      if(apiResponse.isSuccessful){
        var data = apiResponse.body.toJson();
        if(data != null) {
          FollowModel value = FollowModel.fromJson(data);
          this.dataFollow.value = value;
          var data1 = dataFollow.value.data;
          for(int i =0; i <  listFollow.value.data.length  ; i++){
            for(int j = 0 ; j < dataFollow.value.data.length ; j++){
              if( dataFollow.value.data[j].id == listFollow.value.data[i].id ){
                var a = dataFollow.value.data[j];
                print("xóa ${a.id}");
                data1.remove(a);
                i--;
                print(dataFollow.value.data.toString());
                break;
              }
            }
          }
          newFollows = dataFollow;
          print(newFollows.value.data.toString());
          print("finished");
          apiGetFollowList(idUser);
        }
      }
    })
        .catchError((Object onError){
      handleNetWorkError(onError);
    });
  }
}