// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_app/models/follow/user_model.dart';

List<ListUsers> listUsersFromJson(String str) => List<ListUsers>.from(json.decode(str).map((x) => ListUsers.fromJson(x)));

String listUsersToJson(List<ListUsers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListUsers {
  ListUsers({
    this.data,
  });

  UserModel data;

  factory ListUsers.fromJson(Map<String, dynamic> json) => ListUsers(
    data: UserModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}
