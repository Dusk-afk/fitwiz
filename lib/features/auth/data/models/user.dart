import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

String _dateTimeToJson(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

@JsonSerializable()
class User extends Equatable {
  final String salutation;
  final String name;
  final String gender;
  @JsonKey(name: 'date_of_birth', toJson: _dateTimeToJson)
  final DateTime dateOfBirth;
  final String email;
  @JsonKey(name: 'is_admin')
  final bool isAdmin;

  const User({
    required this.salutation,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.email,
    required this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        salutation,
        name,
        gender,
        dateOfBirth,
        email,
        isAdmin,
      ];
}
