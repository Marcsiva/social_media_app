
// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel{
  String? id;
  String uid;
  String username;
  String email;
  String? image;
  String description;
  String phonenumber;


  UserModel({
    this.id,
    required this.uid,
    required this.username,
    required this.email,
     this.image,
     required this.description,
    required this.phonenumber
  });
  factory UserModel.fromJson(Map<String,dynamic> json) => _$UserModelFromJson(json);
  Map<String,dynamic> tojson() => _$UserModelToJson(this);
}