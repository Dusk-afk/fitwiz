import 'package:bloc_test/bloc_test.dart';
import 'package:fitwiz/features/event/data/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:fitwiz/features/event/data/repositories/event_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEventRepository extends Mock implements EventRepository {}

class MockException implements Exception {
  final String message;

  MockException(this.message);

  @override
  String toString() => message;
}

void main() {
  late MockEventRepository mockEventRepository;
  late EventsBloc eventsBloc;

  setUp(() {
    mockEventRepository = MockEventRepository();
    eventsBloc = EventsBloc(mockEventRepository);
  });

  tearDown(() {
    eventsBloc.close();
  });

  blocTest(
    'should emit [EventsSuccess, EventsSuccess] when events are fetched successfully',
    build: () {
      when(() => mockEventRepository.getEvents()).thenAnswer(
        (_) async => [],
      );

      return eventsBloc;
    },
    act: (bloc) {
      bloc.add(FetchEvents());
    },
    expect: () => <EventsState>[
      const EventsSuccess(isLoading: true),
      const EventsSuccess(events: []),
    ],
  );

  blocTest(
    'should emit [EventsSuccess, EventsError] when events are not fetched successfully',
    build: () {
      when(() => mockEventRepository.getEvents())
          .thenThrow(MockException('error'));

      return eventsBloc;
    },
    act: (bloc) {
      bloc.add(FetchEvents());
    },
    expect: () => <EventsState>[
      const EventsSuccess(isLoading: true),
      const EventsError(message: 'error'),
    ],
  );
}
