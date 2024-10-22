import 'package:bloc_test/bloc_test.dart';
import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/models/event_team.dart';
import 'package:fitwiz/features/event/data/repositories/event_repository.dart';
import 'package:fitwiz/features/event/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:fitwiz/features/event/presentation/blocs/my_event_details/my_event_details_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../auth/presentation/bloc/auth_bloc_test.dart';

class MockEventsBloc extends MockBloc<EventsEvent, EventsState>
    implements EventsBloc {}

class MockEventRepository extends Mock implements EventRepository {}

class MockEvent extends Mock implements Event {}

class MockEventTeam extends Mock implements EventTeam {}

void main() {
  late MockEventsBloc mockEventsBloc;
  late MockEventRepository mockEventRepository;
  late MockEvent mockEvent;
  late MockEventTeam mockEventTeam;
  late MyEventDetailsBloc myEventDetailsBloc;
  late MyEventDetailsBloc myEventDetailsBlocNotLoaded;
  late MyEventDetailsBloc myEventDetailsBlocLoaded;
  late MyEventDetailsBloc myEventDetailsBlocLoadedWithEventTeam;

  setUp(() {
    mockEventsBloc = MockEventsBloc();
    mockEventRepository = MockEventRepository();
    mockEvent = MockEvent();
    mockEventTeam = MockEventTeam();
    myEventDetailsBloc =
        MyEventDetailsBloc(mockEventsBloc, mockEventRepository);
    myEventDetailsBlocNotLoaded = MyEventDetailsBloc(
      mockEventsBloc,
      mockEventRepository,
      const MyEventDetailsState(
        errorMessage: 'Events not loaded',
      ),
    );
    myEventDetailsBlocLoaded = MyEventDetailsBloc(
      mockEventsBloc,
      mockEventRepository,
      MyEventDetailsState(event: mockEvent),
    );
    myEventDetailsBlocLoadedWithEventTeam = MyEventDetailsBloc(
      mockEventsBloc,
      mockEventRepository,
      MyEventDetailsState(event: mockEvent, eventTeam: mockEventTeam),
    );
  });

  group('MyEventDetailsBloc', () {
    // ***************** FetchMyEventDetails *****************
    blocTest<MyEventDetailsBloc, MyEventDetailsState>(
      '(1) emits [MyEventDetailsState (error)] when events not loaded on FetchMyEventDetails',
      build: () {
        when(() => mockEventsBloc.state)
            .thenReturn(const EventsError(message: ""));
        return myEventDetailsBloc;
      },
      act: (bloc) => bloc.add(const FetchMyEventDetails(eventId: 1)),
      expect: () => const <MyEventDetailsState>[
        MyEventDetailsState(errorMessage: 'Events not loaded'),
      ],
    );

    blocTest<MyEventDetailsBloc, MyEventDetailsState>(
      '(2) emits [MyEventDetailsState (error)] when events not loaded on FetchMyEventDetails',
      build: () {
        when(() => mockEventsBloc.state)
            .thenReturn(const EventsSuccess(events: [], isLoading: true));
        return myEventDetailsBloc;
      },
      act: (bloc) => bloc.add(const FetchMyEventDetails(eventId: 1)),
      expect: () => const <MyEventDetailsState>[
        MyEventDetailsState(errorMessage: 'Events not loaded'),
      ],
    );

    blocTest<MyEventDetailsBloc, MyEventDetailsState>(
      '(1) emits [MyEventDetailsState (success)] when events loaded on FetchMyEventDetails',
      build: () {
        when(() => mockEventsBloc.state).thenReturn(EventsSuccess(
          events: [mockEvent],
          isLoading: false,
        ));
        when(() => mockEventRepository.getEventTeam(1))
            .thenAnswer((_) async => null);
        when(() => mockEvent.id).thenReturn(1);
        return myEventDetailsBloc;
      },
      act: (bloc) => bloc.add(const FetchMyEventDetails(eventId: 1)),
      expect: () => <MyEventDetailsState>[
        MyEventDetailsState(event: mockEvent, eventTeam: null),
      ],
    );

    blocTest<MyEventDetailsBloc, MyEventDetailsState>(
      '(2) emits [MyEventDetailsState (success)] when events loaded on FetchMyEventDetails',
      build: () {
        when(() => mockEventsBloc.state).thenReturn(EventsSuccess(
          events: [mockEvent],
          isLoading: false,
        ));
        when(() => mockEventRepository.getEventTeam(1))
            .thenAnswer((_) async => mockEventTeam);
        when(() => mockEvent.id).thenReturn(1);
        return myEventDetailsBloc;
      },
      act: (bloc) => bloc.add(const FetchMyEventDetails(eventId: 1)),
      expect: () => <MyEventDetailsState>[
        MyEventDetailsState(event: mockEvent, eventTeam: mockEventTeam),
      ],
    );

    blocTest<MyEventDetailsBloc, MyEventDetailsState>(
      'emit [MyEventDetailsState (error)] when error on FetchMyEventDetails',
      build: () {
        when(() => mockEventsBloc.state).thenReturn(EventsSuccess(
          events: [mockEvent],
          isLoading: false,
        ));
        when(() => mockEventRepository.getEventTeam(1))
            .thenThrow(MockException('error'));
        when(() => mockEvent.id).thenReturn(1);
        return myEventDetailsBloc;
      },
      act: (bloc) => bloc.add(const FetchMyEventDetails(eventId: 1)),
      expect: () => <MyEventDetailsState>[
        const MyEventDetailsState(errorMessage: 'error'),
      ],
    );
    // **************************************************

    // ***************** MyEventDetailsCreateTeam *****************
    blocTest<MyEventDetailsBloc, MyEventDetailsState>(
      'emit same state when event not loaded on MyEventDetailsCreateTeam',
      build: () {
        return myEventDetailsBlocNotLoaded;
      },
      act: (bloc) => bloc.add(MyEventDetailsCreateTeam(
        event: mockEvent,
        teamName: 'Team 1',
      )),
      expect: () => <MyEventDetailsState>[
        myEventDetailsBlocNotLoaded.state,
      ],
    );

    blocTest<MyEventDetailsBloc, MyEventDetailsState>(
      'emit [updating, success] when event loaded on MyEventDetailsCreateTeam',
      build: () {
        when(() => mockEventRepository.createEventTeam(1, 'Team 1'))
            .thenAnswer((_) async => mockEventTeam);
        when(() => mockEvent.id).thenReturn(1);
        return myEventDetailsBlocLoaded;
      },
      act: (bloc) => bloc.add(MyEventDetailsCreateTeam(
        event: mockEvent,
        teamName: 'Team 1',
      )),
      expect: () => <MyEventDetailsState>[
        MyEventDetailsState(
          event: mockEvent,
          isUpdating: true,
          updatingMessage: 'Creating team',
        ),
        MyEventDetailsState(
          event: mockEvent,
          eventTeam: mockEventTeam,
        ),
      ],
    );

    blocTest(
      'emit [updating, error] when error on MyEventDetailsCreateTeam',
      build: () {
        when(() => mockEventRepository.createEventTeam(1, 'Team 1'))
            .thenThrow(MockException('error'));
        when(() => mockEvent.id).thenReturn(1);
        return myEventDetailsBlocLoaded;
      },
      act: (bloc) => bloc.add(MyEventDetailsCreateTeam(
        event: mockEvent,
        teamName: 'Team 1',
      )),
      expect: () => <MyEventDetailsState>[
        MyEventDetailsState(
          event: mockEvent,
          isUpdating: true,
          updatingMessage: 'Creating team',
        ),
        MyEventDetailsState(event: mockEvent, errorMessage: 'error'),
      ],
    );
    // **************************************************

    // ***************** MyEventDetailsJoinTeam *****************
    blocTest<MyEventDetailsBloc, MyEventDetailsState>(
      'emit same state when event not loaded on MyEventDetailsJoinTeam',
      build: () {
        return myEventDetailsBlocNotLoaded;
      },
      act: (bloc) => bloc.add(MyEventDetailsJoinTeam(
        event: mockEvent,
        teamCode: '0A0A',
      )),
      expect: () => <MyEventDetailsState>[
        myEventDetailsBlocNotLoaded.state,
      ],
    );

    blocTest<MyEventDetailsBloc, MyEventDetailsState>(
      'emit [updating, success] when event loaded on MyEventDetailsJoinTeam',
      build: () {
        when(() => mockEventRepository.joinEventTeam(1, '0A0A'))
            .thenAnswer((_) async => mockEventTeam);
        when(() => mockEvent.id).thenReturn(1);
        return myEventDetailsBlocLoaded;
      },
      act: (bloc) => bloc.add(MyEventDetailsJoinTeam(
        event: mockEvent,
        teamCode: '0A0A',
      )),
      expect: () => <MyEventDetailsState>[
        MyEventDetailsState(
          event: mockEvent,
          isUpdating: true,
          updatingMessage: 'Joining team',
        ),
        MyEventDetailsState(
          event: mockEvent,
          eventTeam: mockEventTeam,
        ),
      ],
    );

    blocTest(
      'emit [updating, error] when error on MyEventDetailsJoinTeam',
      build: () {
        when(() => mockEventRepository.joinEventTeam(1, '0A0A'))
            .thenThrow(MockException('error'));
        when(() => mockEvent.id).thenReturn(1);
        return myEventDetailsBlocLoaded;
      },
      act: (bloc) => bloc.add(MyEventDetailsJoinTeam(
        event: mockEvent,
        teamCode: '0A0A',
      )),
      expect: () => <MyEventDetailsState>[
        MyEventDetailsState(
          event: mockEvent,
          isUpdating: true,
          updatingMessage: 'Joining team',
        ),
        MyEventDetailsState(event: mockEvent, errorMessage: 'error'),
      ],
    );
    // **************************************************

    // ***************** MyEventDetailsLeaveTeam *****************
    blocTest<MyEventDetailsBloc, MyEventDetailsState>(
      'emit same state when event not loaded on MyEventDetailsLeaveTeam',
      build: () {
        return myEventDetailsBlocNotLoaded;
      },
      act: (bloc) => bloc.add(MyEventDetailsLeaveTeam(event: mockEvent)),
      expect: () => <MyEventDetailsState>[
        myEventDetailsBlocNotLoaded.state,
      ],
    );

    blocTest<MyEventDetailsBloc, MyEventDetailsState>(
      'emit same state when event not in team on MyEventDetailsLeaveTeam',
      build: () {
        return myEventDetailsBlocLoaded;
      },
      act: (bloc) => bloc.add(MyEventDetailsLeaveTeam(event: mockEvent)),
      expect: () => <MyEventDetailsState>[
        myEventDetailsBlocLoaded.state,
      ],
    );

    blocTest<MyEventDetailsBloc, MyEventDetailsState>(
      'emit [updating, success] when event in team on MyEventDetailsLeaveTeam',
      build: () {
        when(() => mockEventRepository.leaveEventTeam(1))
            .thenAnswer((_) async {});
        when(() => mockEvent.id).thenReturn(1);
        return myEventDetailsBlocLoadedWithEventTeam;
      },
      act: (bloc) => bloc.add(MyEventDetailsLeaveTeam(event: mockEvent)),
      expect: () => <MyEventDetailsState>[
        MyEventDetailsState(
          event: mockEvent,
          eventTeam: mockEventTeam,
          isUpdating: true,
          updatingMessage: 'Leaving team',
        ),
        MyEventDetailsState(
          event: mockEvent,
          eventTeam: null,
        ),
      ],
    );

    blocTest(
      'emit [updating, error] when error on MyEventDetailsLeaveTeam',
      build: () {
        when(() => mockEventRepository.leaveEventTeam(1))
            .thenThrow(MockException('error'));
        when(() => mockEvent.id).thenReturn(1);
        return myEventDetailsBlocLoadedWithEventTeam;
      },
      act: (bloc) => bloc.add(MyEventDetailsLeaveTeam(event: mockEvent)),
      expect: () => <MyEventDetailsState>[
        MyEventDetailsState(
          event: mockEvent,
          eventTeam: mockEventTeam,
          isUpdating: true,
          updatingMessage: 'Leaving team',
        ),
        MyEventDetailsState(
          event: mockEvent,
          eventTeam: mockEventTeam,
          errorMessage: 'error',
        ),
      ],
    );
    // **************************************************
  });
}
