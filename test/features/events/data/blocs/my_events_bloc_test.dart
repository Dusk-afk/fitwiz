import 'package:bloc_test/bloc_test.dart';
import 'package:fitwiz/features/auth/data/models/user.dart';
import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/features/event/data/models/my_event.dart';
import 'package:fitwiz/features/event/data/presentation/blocs/bloc/my_events_bloc.dart';
import 'package:fitwiz/features/event/data/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:fitwiz/features/event/data/repositories/event_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockEventsBloc extends MockBloc<EventsEvent, EventsState>
    implements EventsBloc {}

class MockEventRepository extends Mock implements EventRepository {}

class MockUser extends Mock implements User {}

class MockMyEvent extends Mock implements MyEvent {}

class MockException implements Exception {
  final String message;

  MockException(this.message);

  @override
  String toString() => message;
}

void main() {
  late MockAuthBloc mockAuthBloc;
  late MockEventsBloc mockEventsBloc;
  late MockEventRepository mockEventRepository;
  late MockUser mockUser;
  late MockMyEvent mockMyEvent;
  late MyEventsBloc myEventsBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    mockEventsBloc = MockEventsBloc();
    mockEventRepository = MockEventRepository();
    mockUser = MockUser();
    mockMyEvent = MockMyEvent();
    myEventsBloc =
        MyEventsBloc(mockAuthBloc, mockEventsBloc, mockEventRepository);
  });

  group('MyEventsBloc', () {
    blocTest<MyEventsBloc, MyEventsState>(
      'emits [MyEventsError] when not logged in',
      build: () {
        when(() => mockAuthBloc.state).thenReturn(AuthInitial());
        return myEventsBloc;
      },
      act: (bloc) => bloc.add(FetchMyEvents()),
      expect: () => const <MyEventsState>[
        MyEventsError(message: 'Not logged in'),
      ],
    );

    blocTest<MyEventsBloc, MyEventsState>(
      'emits [MyEventsError] when events not loaded',
      build: () {
        when(() => mockAuthBloc.state).thenReturn(AuthLoggedIn(mockUser));
        when(() => mockEventsBloc.state)
            .thenReturn(const EventsSuccess(isLoading: true));
        return myEventsBloc;
      },
      act: (bloc) => bloc.add(FetchMyEvents()),
      expect: () => const <MyEventsState>[
        MyEventsError(message: 'Events not loaded'),
      ],
    );

    blocTest<MyEventsBloc, MyEventsState>(
      'emits [MyEventsSuccess, MyEventsSuccess] when my events are loaded',
      build: () {
        when(() => mockAuthBloc.state).thenReturn(AuthLoggedIn(mockUser));
        when(() => mockEventsBloc.state).thenReturn(const EventsSuccess());
        when(() => mockEventRepository.getMyEvents())
            .thenAnswer((_) async => [mockMyEvent]);
        return myEventsBloc;
      },
      act: (bloc) => bloc.add(FetchMyEvents()),
      expect: () => <MyEventsState>[
        const MyEventsSuccess(isLoading: true),
        MyEventsSuccess(myEvents: [mockMyEvent]),
      ],
    );

    blocTest<MyEventsBloc, MyEventsState>(
      'emits [MyEventsSuccess, MyEventsError] when my events are not loaded',
      build: () {
        when(() => mockAuthBloc.state).thenReturn(AuthLoggedIn(mockUser));
        when(() => mockEventsBloc.state).thenReturn(const EventsSuccess());
        when(() => mockEventRepository.getMyEvents())
            .thenThrow(MockException('error'));
        return myEventsBloc;
      },
      act: (bloc) => bloc.add(FetchMyEvents()),
      expect: () => <MyEventsState>[
        const MyEventsSuccess(isLoading: true),
        const MyEventsError(message: 'error'),
      ],
    );
  });
}
