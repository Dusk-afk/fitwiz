import 'package:equatable/equatable.dart';
import 'package:fitwiz/features/event/data/models/activity.dart';
import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/models/ticket.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_event.g.dart';

@JsonSerializable()
class MyEvent extends Equatable {
  final Event event;
  final List<Activity> activities;
  final Ticket ticket;

  const MyEvent({
    required this.event,
    required this.activities,
    required this.ticket,
  });

  factory MyEvent.fromJson(Map<String, dynamic> json) =>
      _$MyEventFromJson(json);

  Map<String, dynamic> toJson() => _$MyEventToJson(this);

  factory MyEvent.fromJsonEvent(Map<String, dynamic> json, Event event) {
    return MyEvent(
      event: event,
      activities: (json['activities'] as List)
          .map((e) => Activity.fromJson(e))
          .toList(),
      ticket: Ticket.fromJson(json['ticket']),
    );
  }

  @override
  List<Object?> get props => [event, activities, ticket];

  double getTotalDistanceKm() {
    return activities.fold(
      0,
      (previousValue, element) => previousValue + element.distanceKm,
    );
  }

  Duration getTotalDuration() {
    return activities.fold(
      Duration.zero,
      (previousValue, element) => previousValue + element.duration,
    );
  }

  String getFormattedTotalDuration() {
    final totalDuration = getTotalDuration();
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

  Duration getAveragePace() {
    if (getTotalDistanceKm() == 0) {
      return Duration.zero;
    }

    int seconds = getTotalDuration().inSeconds;
    double pace = seconds / getTotalDistanceKm();

    return Duration(seconds: pace.toInt());
  }

  String getFormattedAveragePace() {
    final averagePace = getAveragePace();
    int minutes = averagePace.inMinutes;
    int seconds = averagePace.inSeconds.remainder(60);

    return '$minutes min $seconds sec';
  }
}
