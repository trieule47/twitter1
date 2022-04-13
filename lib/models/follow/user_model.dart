// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_app/models/follower/follower_model.dart';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

 String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.data,
  });

  FollowerModel data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    data: FollowerModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };

}
