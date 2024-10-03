import 'package:fitwiz/core/services/api_service.dart';
import 'package:fitwiz/core/setup_locator.dart';
import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/models/event_team.dart';
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

  Future<String> createOrder(int eventId) async {
    final response = await _apiService.post('/event/$eventId/create-order');

    // Currently we are only targetting free events
    // Therefore we will return the ticket number

    return response.data['ticket_number'];
  }

  Future<EventTeam?> getEventTeam(int eventId) async {
    final response = await _apiService.get('/me/events/$eventId/team');

    return response.data.isEmpty ? null : EventTeam.fromJson(response.data);
  }

  Future<EventTeam> createEventTeam(int eventId, String name) async {
    final response = await _apiService.post(
      '/me/events/$eventId/team',
      data: {'name': name},
    );

    return EventTeam.fromJson(response.data);
  }

  Future<EventTeam> joinEventTeam(int eventId, String teamCode) async {
    final response = await _apiService.post(
      '/me/events/$eventId/team/join',
      data: {'team_code': teamCode},
    );

    return EventTeam.fromJson(response.data);
  }
}
