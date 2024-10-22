// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      salutation: json['salutation'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
      email: json['email'] as String,
      isAdmin: json['is_admin'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'salutation': instance.salutation,
      'name': instance.name,
      'gender': instance.gender,
      'date_of_birth': _dateTimeToJson(instance.dateOfBirth),
      'email': instance.email,
      'is_admin': instance.isAdmin,
    };
