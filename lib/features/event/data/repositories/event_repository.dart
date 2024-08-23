import 'package:fitwiz/core/services/api_service.dart';
import 'package:fitwiz/core/setup_locator.dart';
import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/models/my_event.dart';
import 'package:fitwiz/features/event/presentation/blocs/events_bloc/events_bloc.dart';

class EventRepository {
  final ApiService _apiService;

  EventRepository(this._apiService);

  Future<List<Event>> getEvents({int page = 1, int pageSize = 100}) async {
    final response = await _apiService.get(
      '/event/all',
      queryParams: {
        'page': page,
        'page_size': pageSize,
      },
    );

    return (response.data as List).map((e) => Event.fromJson(e)).toList();
  }

  Future<List<MyEvent>> getMyEvents({
    int page = 1,
    int pageSize = 100,
    EventsBloc? eventsBloc,
  }) async {
    eventsBloc ??= locator<EventsBloc>();
    if (eventsBloc.state is! EventsSuccess ||
        (eventsBloc.state as EventsSuccess).isLoading) {
      return [];
    }

    final response = await _apiService.get(
      '/me/events',
      queryParams: {
        'page': page,
        'page_size': pageSize,
      },
    );

    final Map<int, Event> events = {
      for (Event e in (eventsBloc.state as EventsSuccess).events) e.id: e
    };

    return (response.data as List).map((e) {
      final event = events[e['event_id']]!;
      return MyEvent.fromJsonEvent(e, event);
    }).toList();
  }
}
