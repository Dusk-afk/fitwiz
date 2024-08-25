// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tower.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tower _$TowerFromJson(Map<String, dynamic> json) => Tower(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      society: Society.fromJson(json['society'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TowerToJson(Tower instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'society': _societyToJson(instance.society),
    };
