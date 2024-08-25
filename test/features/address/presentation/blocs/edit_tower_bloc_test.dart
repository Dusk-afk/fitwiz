import 'package:bloc_test/bloc_test.dart';
import 'package:fitwiz/features/address/data/models/society.dart';
import 'package:fitwiz/features/address/data/models/tower.dart';
import 'package:fitwiz/features/address/data/models/tower_short.dart';
import 'package:fitwiz/features/address/data/repositories/address_repository.dart';
import 'package:fitwiz/features/address/presentation/blocs/edit_tower/edit_tower_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../auth/presentation/bloc/auth_bloc_test.dart';

class MockAddressRepository extends Mock implements AddressRepository {}

class MockSociety extends Mock implements Society {}

void main() {
  late MockAddressRepository mockAddressRepository;
  late MockSociety mockSociety;
  late EditTowerBloc editTowerBloc;

  setUp(() {
    mockAddressRepository = MockAddressRepository();
    mockSociety = MockSociety();
    editTowerBloc = EditTowerBloc(mockAddressRepository);
  });

  tearDown(() {
    editTowerBloc.close();
  });

  blocTest(
    'should emit [EditTowerLoading, EditTowerLoaded] when towers are fetched successfully',
    build: () {
      when(() => mockAddressRepository.getTowersBySociety(mockSociety))
          .thenAnswer(
        (_) async => [
          Tower(id: 1, name: 'A', society: mockSociety),
        ],
      );

      return editTowerBloc;
    },
    act: (bloc) => bloc.add(FetchTowers(mockSociety)),
    expect: () => <EditTowerState>[
      const EditTowerLoading(),
      const EditTowerLoaded([
        TowerShort(id: 1, name: 'A'),
      ]),
    ],
  );

  blocTest(
    'should emit [EditTowerLoading, EditTowerError] when towers are not fetched successfully',
    build: () {
      when(() => mockAddressRepository.getTowersBySociety(mockSociety))
          .thenThrow(MockException('Error fetching towers'));

      return editTowerBloc;
    },
    act: (bloc) => bloc.add(FetchTowers(mockSociety)),
    expect: () => <EditTowerState>[
      const EditTowerLoading(),
      const EditTowerError('Error fetching towers'),
    ],
  );
}
