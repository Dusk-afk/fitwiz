import 'package:dio/dio.dart';
import 'package:fitwiz/core/services/api_service.dart';
import 'package:fitwiz/data/models/user_short.dart';
import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/models/event_team.dart';
import 'package:fitwiz/features/event/presentation/blocs/events_bloc/events_bloc.dart';
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

    test('should throw exception if api call is unsuccessful on events', () {
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

    test(
        'should return ticket number if api call is successful on create-order',
        () async {
      when(() => mockApiService.post('/event/1/create-order'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/event/1/create-order'),
                data: {'ticket_number': '123456'},
              ));

      final ticketNumber = await eventRepository.createOrder(1);

      expect(ticketNumber, '123456');
    });

    test('should throw exception if api call is unsuccessful on create-order',
        () {
      when(() => mockApiService.post('/event/1/create-order'))
          .thenThrow(Exception('error'));

      expect(() async => await eventRepository.createOrder(1), throwsException);
    });

    test(
        'should return no team if api call is successful on getEventTeam and data is empty',
        () async {
      when(() => mockApiService.get('/me/events/1/team'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/me/events/1/team'),
                data: {},
              ));

      final eventTeam = await eventRepository.getEventTeam(1);

      expect(eventTeam, null);
    });

    test('should return team if api call is successful on getEventTeam',
        () async {
      when(() => mockApiService.get('/me/events/1/team'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/me/events/1/team'),
                data: {
                  'id': 1,
                  'event_id': 1,
                  'team_code': '0A0A',
                  'name': 'Team 1',
                  'leader': {
                    'id': 1,
                    'name': 'John Doe',
                  },
                  'members': [
                    {
                      'id': 2,
                      'name': 'Jane Doe',
                    },
                  ],
                },
              ));

      final eventTeam = await eventRepository.getEventTeam(1);

      expect(
        eventTeam,
        const EventTeam(
          id: 1,
          eventId: 1,
          teamCode: '0A0A',
          name: 'Team 1',
          leader: UserShort(id: 1, name: 'John Doe'),
          members: [UserShort(id: 2, name: 'Jane Doe')],
        ),
      );
    });

    test('should throw exception if api call is unsuccessful on getEventTeam',
        () {
      when(() => mockApiService.get('/me/events/1/team'))
          .thenThrow(Exception('error'));

      expect(
          () async => await eventRepository.getEventTeam(1), throwsException);
    });

    test('should return team if api call is successful on createEventTeam',
        () async {
      when(() =>
              mockApiService.post('/me/events/1/team', data: {'name': 'name'}))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/me/events/1/team'),
                data: {
                  'id': 1,
                  'event_id': 1,
                  'team_code': '0A0A',
                  'name': 'Team 1',
                  'leader': {
                    'id': 1,
                    'name': 'John Doe',
                  },
                  'members': [
                    {
                      'id': 2,
                      'name': 'Jane Doe',
                    },
                  ],
                },
              ));

      final eventTeam = await eventRepository.createEventTeam(1, 'name');

      expect(
        eventTeam,
        const EventTeam(
          id: 1,
          eventId: 1,
          teamCode: '0A0A',
          name: 'Team 1',
          leader: UserShort(id: 1, name: 'John Doe'),
          members: [UserShort(id: 2, name: 'Jane Doe')],
        ),
      );
    });

    test(
        'should throw exception if api call is unsuccessful on createEventTeam',
        () {
      when(() =>
              mockApiService.post('/me/events/1/team', data: {'name': 'name'}))
          .thenThrow(Exception('error'));

      expect(() async => await eventRepository.createEventTeam(1, 'name'),
          throwsException);
    });

    test('should return team if api call is successful on joinEventTeam',
        () async {
      when(() => mockApiService
              .post('/me/events/1/team/join', data: {'team_code': 'team_code'}))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/me/events/1/team/join'),
                data: {
                  'id': 1,
                  'event_id': 1,
                  'team_code': '0A0A',
                  'name': 'Team 1',
                  'leader': {
                    'id': 1,
                    'name': 'John Doe',
                  },
                  'members': [
                    {
                      'id': 2,
                      'name': 'Jane Doe',
                    },
                  ],
                },
              ));

      final eventTeam = await eventRepository.joinEventTeam(1, 'team_code');

      expect(
        eventTeam,
        const EventTeam(
          id: 1,
          eventId: 1,
          teamCode: '0A0A',
          name: 'Team 1',
          leader: UserShort(id: 1, name: 'John Doe'),
          members: [UserShort(id: 2, name: 'Jane Doe')],
        ),
      );
    });

    test('should throw exception if api call is unsuccessful on joinEventTeam',
        () {
      when(() => mockApiService.post('/me/events/1/team/join',
          data: {'team_code': 'team_code'})).thenThrow(Exception('error'));

      expect(() async => await eventRepository.joinEventTeam(1, 'team_code'),
          throwsException);
    });

    test('should return nothing if api call is suuccessful on leaveEventTeam',
        () async {
      when(() => mockApiService.delete('/me/events/1/team'))
          .thenAnswer((_) async => Response(
                requestOptions:
                    RequestOptions(path: '/me/events/1/team', method: 'DELETE'),
                data: {},
              ));

      await eventRepository.leaveEventTeam(1);
      verify(() => mockApiService.delete('/me/events/1/team')).called(1);
    });

    test('should throw exception if api call is unsuccessful on leaveEventTeam',
        () {
      when(() => mockApiService.delete('/me/events/1/team'))
          .thenThrow(Exception('error'));

      expect(
          () async => await eventRepository.leaveEventTeam(1), throwsException);
    });
  });
}
