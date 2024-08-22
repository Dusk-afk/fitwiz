import 'package:dio/dio.dart';
import 'package:fitwiz/core/services/api_service.dart';
import 'package:fitwiz/features/event/data/repositories/event_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;
  late EventRepository eventRepository;

  setUp(() {
    mockApiService = MockApiService();
    eventRepository = EventRepository(mockApiService);
  });

  group('EventRepository', () {
    test('should return list of events if api call is successful', () async {
      // Empty because the json parsing is tested in the model test
      final eventsJson = [];

      when(() => mockApiService.get('/event/all',
              queryParams: any(named: 'queryParams')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/event/all'),
                data: eventsJson,
              ));

      final events = await eventRepository.getEvents();

      expect(events.length, 0);
    });

    test('should throw exception if api call is unsuccessful', () {
      when(() => mockApiService.get('/event/all',
              queryParams: any(named: 'queryParams')))
          .thenThrow(Exception('error'));

      expect(() async => await eventRepository.getEvents(), throwsException);
    });
  });
}
