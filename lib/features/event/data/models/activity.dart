import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity extends Equatable {
  final int id;

  @JsonKey(name: 'activity_type')
  final String activityType;

  @JsonKey(name: 'distance_km')
  final double distanceKm;

  @JsonKey(name: 'start_datetime')
  final DateTime startDateTime;

  @JsonKey(name: 'end_datetime')
  final DateTime endDateTime;

  const Activity({
    required this.id,
    required this.activityType,
    required this.distanceKm,
    required this.startDateTime,
    required this.endDateTime,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  @override
  List<Object?> get props =>
      [id, activityType, distanceKm, startDateTime, endDateTime];

  Duration get duration => endDateTime.difference(startDateTime);

  String get formattedDuration {
    final totalDuration = duration;
    String result = '';
    int hours = totalDuration.inHours;
    int minutes = totalDuration.inMinutes.remainder(60);
    int seconds = totalDuration.inSeconds.remainder(60);

    if (hours > 0) {
      result += '$hours hr ';
    }

    if (minutes > 0) {
      result += '$minutes min ';
    }

    if (seconds > 0) {
      result += '$seconds sec';
    }

    if (result.isEmpty) {
      result = '0 sec';
    }

    return result.trim();
  }

  Duration get pace {
    if (distanceKm == 0) {
      return Duration.zero;
    }
    int seconds = duration.inSeconds;
    double pace = seconds / distanceKm;
    return Duration(seconds: pace.toInt());
  }

  String get formattedPace {
    final totalPace = pace;
    String result = '';
    int minutes = totalPace.inMinutes;
    int seconds = totalPace.inSeconds.remainder(60);

    if (minutes > 0) {
      result += '$minutes min ';
    }

    if (seconds > 0) {
      result += '$seconds sec';
    }

    if (result.isEmpty) {
      result = '0 sec';
    }

    return result.trim();
  }
}
