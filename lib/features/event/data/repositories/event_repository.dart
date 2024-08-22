import 'package:fitwiz/core/services/api_service.dart';
import 'package:fitwiz/features/event/data/models/event.dart';

class EventRepository {
  late final ApiService _apiService;

  EventRepository(this._apiService);

  Future<List<Event>> getEvents({int page = 1, int pageSize = 10}) async {
    final response = await _apiService.get(
      '/event/all',
      queryParams: {
        'page': page,
        'page_size': pageSize,
      },
    );

    return (response.data as List).map((e) => Event.fromJson(e)).toList();
  }
}
