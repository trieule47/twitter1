import 'package:flutter_app/models/follower/follower_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:get/get.dart';
part 'follow_model.g.dart';

@JsonSerializable()
class FollowModel {
   List<FollowerModel> data;
   //= List<FollowerModel>();
 //var data =  List<FollowerModel>();
  dynamic meta;

  FollowModel({
    this.data,
    this.meta,
  });

  factory FollowModel.fromJson(Map<String, dynamic> json) =>
      _$FollowModelFromJson(json);

  Map<String, dynamic> toJson() => _$FollowModelToJson(this);

}
