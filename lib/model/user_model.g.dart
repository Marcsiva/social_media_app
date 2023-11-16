// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      uid: json['uid'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
      description: json['description'] as String,
      phonenumber: json['phonenumber'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'username': instance.username,
      'email': instance.email,
      'image': instance.image,
      'description': instance.description,
      'phonenumber': instance.phonenumber,
    };
