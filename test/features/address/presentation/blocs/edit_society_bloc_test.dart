import 'package:bloc_test/bloc_test.dart';
import 'package:fitwiz/features/address/data/models/society.dart';
import 'package:fitwiz/features/address/data/repositories/address_repository.dart';
import 'package:fitwiz/features/address/presentation/blocs/edit_society/edit_society_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../auth/presentation/bloc/auth_bloc_test.dart';

class MockAddressRepository extends Mock implements AddressRepository {}

class MockSociety extends Mock implements Society {}

void main() {
  late MockAddressRepository mockAddressRepository;
  late List<MockSociety> mockSocieties;
  late EditSocietyBloc editSocietyBloc;

  setUp(() {
    mockAddressRepository = MockAddressRepository();
    mockSocieties = List.generate(3, (index) => MockSociety());
    editSocietyBloc = EditSocietyBloc(mockAddressRepository);
  });

  tearDown(() {
    editSocietyBloc.close();
  });

  blocTest(
    'should emit [EditSocietyLoading, EditSocietyLoaded] when society is fetched successfully',
    build: () {
      when(() => mockAddressRepository.getSocieties()).thenAnswer(
        (_) async => mockSocieties,
      );

      return editSocietyBloc;
    },
    act: (bloc) => bloc.add(FetchSocieties()),
    expect: () => <EditSocietyState>[
      const EditSocietyLoading(),
      EditSocietyLoaded(mockSocieties),
    ],
  );

  blocTest(
    'should emit [EditSocietyLoading, EditSocietyError] when society is not fetched successfully',
    build: () {
      when(() => mockAddressRepository.getSocieties())
          .thenThrow(MockException('Error fetching societies'));

      return editSocietyBloc;
    },
    act: (bloc) => bloc.add(FetchSocieties()),
    expect: () => <EditSocietyState>[
      const EditSocietyLoading(),
      const EditSocietyError('Error fetching societies'),
    ],
  );
}
