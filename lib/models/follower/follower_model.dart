import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'follower_model.g.dart';

@JsonSerializable()
class FollowerModel {
  String id;
  String name;
  String username;

  FollowerModel({
    this.id,
    this.name,
    this.username,
  });

  factory FollowerModel.fromJson(Map<String, dynamic> json) =>
    _$FollowerModelFromJson(json);
}