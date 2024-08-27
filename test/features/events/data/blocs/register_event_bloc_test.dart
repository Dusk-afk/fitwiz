import 'package:bloc_test/bloc_test.dart';
import 'package:fitwiz/features/event/data/repositories/event_repository.dart';
import 'package:fitwiz/features/event/presentation/blocs/event_register/event_register_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../auth/presentation/bloc/auth_bloc_test.dart';

class MockEventRepository extends Mock implements EventRepository {}

void main() {
  late MockEventRepository mockEventRepository;
  late EventRegisterBloc eventRegisterBloc;

  setUp(() {
    mockEventRepository = MockEventRepository();
    eventRegisterBloc = EventRegisterBloc(mockEventRepository);
  });

  tearDown(() {
    eventRegisterBloc.close();
  });

  group('RegisterEventBloc', () {
    blocTest(
      'should emit [EventRegisterLoading, EventRegisterSuccess] on succesful registration',
      build: () {
        when(() => mockEventRepository.createOrder(1))
            .thenAnswer((_) async => "123");
        return eventRegisterBloc;
      },
      act: (bloc) => bloc.add(const RegisterEvent(1)),
      expect: () => <EventRegisterState>[
        EventRegisterLoading(),
        const EventRegisterSuccess("123"),
      ],
    );

    blocTest(
      'should emit [EventRegisterLoading, EventRegisterError] on failed registration',
      build: () {
        when(() => mockEventRepository.createOrder(1))
            .thenThrow(MockException('error'));
        return eventRegisterBloc;
      },
      act: (bloc) => bloc.add(const RegisterEvent(1)),
      expect: () => <EventRegisterState>[
        EventRegisterLoading(),
        const EventRegisterError("error"),
      ],
    );
  });
}
