import 'package:dio/dio.dart';
import 'package:fitwiz/core/services/api_service.dart';
import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:fitwiz/features/event/data/repositories/event_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

class MockEventsBloc extends Mock implements EventsBloc {}

class MockEvent extends Mock implements Event {}

void main() {
  late MockApiService mockApiService;
  late MockEventsBloc mockEvensBloc;
  late EventRepository eventRepository;

  setUp(() {
    mockApiService = MockApiService();
    mockEvensBloc = MockEventsBloc();
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

    test('should return list of my events if api call is successful', () async {
      final mockEvent = MockEvent();
      when(() => mockEvent.id).thenReturn(1);
      when(() => mockEvensBloc.state).thenReturn(EventsSuccess(
        events: [mockEvent],
      ));
      when(() => mockApiService.get('/me/events',
              queryParams: any(named: 'queryParams')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/me/events'),
                data: [
                  {
                    'event_id': 1,
                    'activities': [],
                    'ticket': {
                      'payment_id': 123,
                      'ticket_number': '123456',
                      'issued_at': '2021-10-10T10:00:00Z',
                    },
                  }
                ],
              ));

      final myEvents =
          await eventRepository.getMyEvents(eventsBloc: mockEvensBloc);

      expect(myEvents.length, 1);
      expect(myEvents[0].event.id, 1);
      expect(myEvents[0].activities, []);
      expect(myEvents[0].ticket.paymentId, 123);
      expect(myEvents[0].ticket.ticketNumber, '123456');
      expect(
          myEvents[0].ticket.issuedAt, DateTime.parse('2021-10-10T10:00:00Z'));

      verify(() => mockEvensBloc.state).called(3);
      verify(() => mockApiService.get('/me/events',
          queryParams: any(named: 'queryParams'))).called(1);
    });

    test('should return empty list if eventsBloc is not in success state',
        () async {
      when(() => mockEvensBloc.state)
          .thenReturn(const EventsError(message: 'error'));

      final myEvents =
          await eventRepository.getMyEvents(eventsBloc: mockEvensBloc);

      expect(myEvents.length, 0);

      verify(() => mockEvensBloc.state).called(1);
    });

    test(
        'should return empty list if eventsBloc is in success state but loading',
        () async {
      when(() => mockEvensBloc.state)
          .thenReturn(const EventsSuccess(isLoading: true, events: []));

      final myEvents =
          await eventRepository.getMyEvents(eventsBloc: mockEvensBloc);

      expect(myEvents.length, 0);

      verify(() => mockEvensBloc.state).called(2);
    });

    test('should throw exception if api call is unsuccessful', () {
      when(() => mockEvensBloc.state).thenReturn(EventsSuccess(
        events: [MockEvent()],
      ));
      when(() => mockApiService.get('/me/events',
              queryParams: any(named: 'queryParams')))
          .thenThrow(Exception('error'));

      expect(
          () async =>
              await eventRepository.getMyEvents(eventsBloc: mockEvensBloc),
          throwsException);
    });
  });
}
