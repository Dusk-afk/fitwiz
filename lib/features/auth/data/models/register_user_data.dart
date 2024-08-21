import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_user_data.g.dart';

String _dateTimeToJson(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

@JsonSerializable()
class RegisterUserData extends Equatable {
  final String salutation;
  final String name;
  final String gender;
  @JsonKey(name: 'date_of_birth', toJson: _dateTimeToJson)
  final DateTime dateOfBirth;
  final String email;
  final String password;

  const RegisterUserData({
    required this.salutation,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.email,
    required this.password,
  });

  factory RegisterUserData.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserDataToJson(this);

  @override
  List<Object?> get props => [salutation, name, gender, email, password];
}
