// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterUserData _$RegisterUserDataFromJson(Map<String, dynamic> json) =>
    RegisterUserData(
      salutation: json['salutation'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegisterUserDataToJson(RegisterUserData instance) =>
    <String, dynamic>{
      'salutation': instance.salutation,
      'name': instance.name,
      'gender': instance.gender,
      'date_of_birth': _dateTimeToJson(instance.dateOfBirth),
      'email': instance.email,
      'password': instance.password,
    };
