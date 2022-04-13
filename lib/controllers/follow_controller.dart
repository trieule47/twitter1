import 'package:flutter_app/models/follow/user_model.dart';
import 'package:flutter_app/models/follower/follower_model.dart';
import 'package:flutter_app/repositories/follow_repositories.dart';
import 'package:flutter_app/utils/storage_util.dart';

import 'base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app/models/follow/follow_model.dart';

import 'dart:convert';

class FollowController extends BaseController {
  // var listFollow =  FollowModel(data: []).obs;
  // var newFollows =  FollowModel(data: []).obs;
  // var dataFollow =  FollowModel(data: []).obs;
  // var dataUnFollow =  FollowModel(data: []).obs;
  // var dataBetween =  FollowModel(data: []).obs;
  List<FollowerModel> listFollow = List<FollowerModel>().obs;
  List<FollowerModel> newFollows = List<FollowerModel>().obs;
  List<FollowerModel> dataFollow = List<FollowerModel>().obs;
  List<FollowerModel> dataUnFollow = List<FollowerModel>().obs;
  List<FollowerModel> dataBetween = List<FollowerModel>().obs;
  //var listFollow =  List<FollowerModel>().obs;
  // var newFollows =  List<FollowerModel>().obs;
  // var dataFollow =  List<FollowerModel>().obs;
  // var dataUnFollow =  List<FollowerModel>().obs;
  // var dataBetween =  List<FollowerModel>().obs;

  var User = UserModel().obs;
  List<dynamic> ListUsers = List<FollowerModel>().obs;
  List<dynamic> Suggestions = List<dynamic>().obs;
  List<dynamic> allListFollows = List<dynamic>().obs;
  List<dynamic> allListNewFollows = List<dynamic>().obs;
  List<dynamic> allListDataFollow = List<dynamic>().obs;
  List<dynamic> allListDataUnFollow = List<dynamic>().obs;

  //var idUser = 1445088239556067329;
  TextEditingController searchTextController;

  final FollowRepository _followRepo = FollowRepository.getInstance();

  @override
  void onInit() {
    // StorageUtil.deleteItem(StorageUtil.dataUnFollow);
    // StorageUtil.deleteItem(StorageUtil.dataFollow);
    // StorageUtil.deleteItem(StorageUtil.listUsers);
    // StorageUtil.deleteItem(StorageUtil.listFollow);
    // this.Suggestions.add('TGioanB');
    // this.Suggestions.add('nshzvs');
    //setListUsers();
    getSuggestion();
    getListUsers();
    print('list users start: ' + ListUsers.toString());
    getListFollow();
    print('List follow L' + allListFollows.toString());
    getDataFollow();
    print('datafl ${this.dataFollow.toString()}');
    getDataUnFollow();
    print('dataufl ${this.dataUnFollow.toString()}');
    searchTextController = TextEditingController();
    // this.showLoading();
    // apiGetFollowList(idUser);
    super.onInit();
  }

  //search by id user
  GetFollowList(int id) {
    // getListUsers();
    // getSuggestion();
    var index = ListUsers.length - 1;
    setDataFollow(index, []);
    setDataUnFollow(index, []);
    //setListFollow(id, value.data);
    this.showLoading();
    apiGetFollowList(id);
  }

  Future<void> apiGetFollowList(int id) async {
    //this.showLoading();
    await _followRepo.getListFollow(id).then((apiResponse) {
      this.closeLoading();
      if (apiResponse.isSuccessful) {
        var data = apiResponse.body.toJson();
        if (data != null) {
          FollowModel value = FollowModel.fromJson(data);
          this.listFollow = value.data;
          setListFollow(id, value.data);
          print('list follow of : $id; length: ${listFollow.length} a');
        }
      }
    }).catchError((Object onError) {
      handleNetWorkError(onError);
    });
  }

  ///general list
  void initialList(index) {
    for (var i in this.allListFollows[index][1]) {
      // print('a: ${i.name}, : data ${dataFollow.value.data.toString()}');
      dataUnFollow.add(i);
    }
    for (var i in newFollows) {
      dataFollow.add(i);
    }
  }

  ///list new follow of user
  Future<void> NewFollows(id, index) async {
    var ID = int.parse(id);
    this.showLoading();
    await _followRepo.getListFollow(ID).then((apiResponse) {
      this.closeLoading();
      if (apiResponse.isSuccessful) {
        var data = apiResponse.body.toJson();
        if (data != null) {
          FollowModel value = FollowModel.fromJson(data);
          this.newFollows = value.data;
          print('username1 : ${this.newFollows[0].username}');
          initialList(index);
          var nA = dataUnFollow;
          var nB = dataFollow;
          print('username : ${nA[0].username}');
          for (int i = 0; i < nA.length; i++) {
            for (int j = 0; j < nB.length; j++) {
              if (nA[i].id == nB[j].id) {
                dataBetween.add(nA[i]);
                print("add: $i");
                nA.remove(
                    nA[i]); // phần bù của A với 'A giao B' ra list unfollow
                nB.remove(
                    nB[j]); // phần bù của B với 'A giao B' ra list new follow
                print("dataUnFollow: ${nA.length} ");
                print("dataFollow: ${nB.length}");
                i--;
                break;
              }
            }
          }
          //this.allListDateUnFollow.add(nA);
          if (nA.isEmpty && nB.isEmpty) {
            this.showMessage(
                title: "${this.ListUsers[index].username}: nothing new",
                message: " nothing");
          }
          setDataFollow(index, nB);
          setDataUnFollow(index, nA);
          //this.allListDataFollow.add(nB);
          setListFollow(ID, value.data);
          listFollow = new List<FollowerModel>().obs; //initial new one
          for (var i in newFollows) {
            listFollow.add(i);
          } // câp nhập listfollow cũ
          //print('new ${listFollow.value.data.toString()}');
        }
      }
    }).catchError((Object onError) {
      handleNetWorkError(onError);
    });
  }

  ///new all follow of all user
  void newAllListFollow() {
    List<FollowerModel> list;
    list = this.ListUsers;
    if (list != []) {
      var l = list.length;
      for (var i = 0; i < l; i++) {
        NewFollows(list[i].id, i);
      }
    }
  }

  // get user by username
  Future<void> getUserByUsername(String username) async {
    this.showLoading();
    await _followRepo.getUser(username).then((apiResponse) {
      this.closeLoading();
      if (apiResponse.isSuccessful) {
        var data = apiResponse.body.toJson();
        if (data != null) {
          UserModel value = UserModel.fromJson(data);
          setListUsers(value.data);
          ///check exist and add
        }
      }
    }).catchError((Object onError) {
      handleNetWorkError(onError);
    });
  }
  ///storage
  void storageOnLocal(name, item) {
    dynamic data = toJSONEncodable(item);
    StorageUtil.storeItem(name, data);
    print('add to allList: ${item.toString()} : $data');
  }
  ///storage all data follow
  Future setDataFollow(index, data) async {
    var indexMax = this.allListDataFollow.length;
    if (index < indexMax) {
      this.allListDataFollow[index] = data;
    } else {
      this.allListDataFollow.add(data);
    }
    await StorageUtil.storeItem(
        StorageUtil.dataFollow, toJSONEncodable(this.allListDataFollow));
  }

  ///get all data follow
  Future getDataFollow() async {
    var data = await StorageUtil.retrieveItem(StorageUtil.dataFollow);
    print("data f: $data");
    if (data != null) {
      var lists = fromJSONDecode(data);
      print('data f: $data');
      for (var a in lists) {
        List<FollowerModel> newList = toListUsers(a);
        this.allListDataFollow.add(newList);
      }
    }
  }

  ///storage all data unfollow
  Future setDataUnFollow(index, data) async {
    var indexMax = this.allListDataUnFollow.length;
    if (index < indexMax) {
      this.allListDataUnFollow[index] = data;
    } else {
      this.allListDataUnFollow.add(data);
    }
    await StorageUtil.storeItem(
        StorageUtil.dataUnFollow, toJSONEncodable(this.allListDataUnFollow));
  }

  ///get all data unfollow
  Future getDataUnFollow() async {
    var data = await StorageUtil.retrieveItem(StorageUtil.dataUnFollow);
    if (data != null) {
      var lists = fromJSONDecode(data);
      print('data un: $data');
      print('data un: $lists');

      for (var a in lists) {
        List<FollowerModel> newList = toListUsers(a);
        this.allListDataUnFollow.add(newList);
      }
    }
  }

  ///check repeat suggestion
  bool checkRepeatSuggestion(String item, List<dynamic> items) {
    bool check = false;
    for (String a in items) {
      if (a == item) {
        check = true;
        break;
      }
    }
    return check;
  }

  ///storage suggestions
  Future setSuggestion(String item) async {
    if (checkRepeatSuggestion(item, this.Suggestions) == false) {
      this.Suggestions.add(item); // add new suggest
    }
    await StorageUtil.storeItem(
        StorageUtil.suggestions, toJSONEncodable(this.Suggestions));
  }

  /// get suggestions
  Future<void> getSuggestion() async {
    var a = await StorageUtil.retrieveItem(StorageUtil.suggestions);
    if (a != null) {
      this.Suggestions = fromJSONDecode(a);
      print('suggests : ${Suggestions.toString()}');
    }
  }

  ///check repeat users
  bool checkRepeatUser(FollowerModel item, dynamic items) {
    bool check = false;
    for (FollowerModel a in items) {
      if (a.id == item.id) {
        check = true;
        break;
      }
    }
    return check;
  }

  /// storage listUsers
  Future setListUsers(FollowerModel item) async {
    if (checkRepeatUser(item, this.ListUsers) == false) {
      this.ListUsers.add(item); // add new ListUser
      GetFollowList(int.parse(item.id));
    }
    // dynamic data = toJSONEncodable(this.ListUsers); //conver to json
    //
    // await StorageUtil.storeItem(StorageUtil.listUsers, data);
    await storageOnLocal(StorageUtil.listUsers, this.ListUsers);
    ///save user
  }

  /// get listUsers
  Future<void> getListUsers() async {
    var data = await StorageUtil.retrieveItem(StorageUtil.listUsers);
    if (data != null) {
      var lists = fromJSONDecode(data);
      print(lists.toString());
      List<FollowerModel> newList = toListUsers(lists).obs;
      this.ListUsers = newList;
      print('List users here: ${ListUsers.toString()}');
    }
  }

  ///storage listFollow of all users
  Future setListFollow(id, List<FollowerModel> item) async {
    if (this.allListFollows != []) {
      var check = false;
      for (var a in this.allListFollows) {
        if (a[0] == id.toString()) {
          a[1] = item;
          check = true;
        }
      }
      if (check == false) this.allListFollows.add([id.toString(), item]);
    } else {
      this.allListFollows.add([id.toString(), item]);
    }
    await storageOnLocal(StorageUtil.listFollow, this.allListFollows);

  }

  ///get listFollow of all
  Future<List<dynamic>> getListFollow() async {
    var data = await StorageUtil.retrieveItem(StorageUtil.listFollow);
    if (data != null) {
      print('local: ${fromJSONDecode(data).toString()}');
      var lists = fromJSONDecode(data);
      List<dynamic> newLists = List<dynamic>().obs;
      newLists = toListFollow(lists);
      print('local listfollow fromJson : ${newLists.toString()}');

      return newLists;
    }
  }

  ///convert to list users
  List<FollowerModel> toListUsers(data) {
    List<FollowerModel> newLists = [];
    for (var a in data) {
      FollowerModel list = FollowerModel.fromJson(a);
      newLists.add(list);
    }
    print('local user here : ${newLists.toString()}');
    return newLists;
  }

  ///convert to list FollowModel
  List<dynamic> toListFollow(data) {
    List<dynamic> newLists = [];
    for (var a in data) {
      List<FollowerModel> childs = [];
      for (var a1 in a[1]) {
        FollowerModel list = FollowerModel.fromJson(a1);
        //print('local fromJson : ${list.name}');
        childs.add(list);
      }
      newLists.add([a[0], childs]);
    }
    print('local fromJson : ${newLists.toString()}');
    return newLists;
  }

  ///convert to json
  toJSONEncodable(dynamic data) {
    Map<String, dynamic> m = new Map();
    m['data'] = data;
    return m;
  }

  ///convert from json
  fromJSONDecode(Map<String, dynamic> json) {
    return json['data'];
  }

  void removeItem(index) {
    this.ListUsers.removeAt(index);
    storageOnLocal(StorageUtil.listUsers, this.ListUsers);
    // print('user remove: ${ListUsers.toString()}');
    // this.setListFollow(item.id, item);
    this.allListFollows.removeAt(index);
    storageOnLocal(StorageUtil.listFollow, this.allListFollows);
    print('datafl remove: ${listFollow.toString()}');
    this.allListDataFollow.removeAt(index);
    storageOnLocal(StorageUtil.dataFollow, this.allListDataFollow);
    print('dataufl remove: ${dataFollow.toString()}');
    this.allListDataUnFollow.removeAt(index);
    storageOnLocal(StorageUtil.dataUnFollow, this.allListDataUnFollow);
    print('user remove: ${dataUnFollow.toString()}');


  }
  void reset() {
    // StorageUtil.deleteItem(StorageUtil.listUsers);
    // StorageUtil.deleteItem(StorageUtil.listFollow);
    // StorageUtil.deleteItem(StorageUtil.dataFollow);
    // StorageUtil.deleteItem(StorageUtil.dataUnFollow);
  }
}
