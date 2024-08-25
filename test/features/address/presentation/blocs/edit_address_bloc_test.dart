import 'package:bloc_test/bloc_test.dart';
import 'package:fitwiz/features/address/data/models/address.dart';
import 'package:fitwiz/features/address/data/repositories/address_repository.dart';
import 'package:fitwiz/features/address/presentation/blocs/edit_address/edit_address_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../auth/presentation/bloc/auth_bloc_test.dart';

class MockAddressRepository extends Mock implements AddressRepository {}

class MockAddress extends Mock implements Address {}

void main() {
  late MockAddressRepository mockAddressRepository;
  late MockAddress mockAddress;
  late EditAddressBloc editAddressBloc;

  setUp(() {
    mockAddressRepository = MockAddressRepository();
    mockAddress = MockAddress();
    editAddressBloc = EditAddressBloc(mockAddressRepository);
  });

  tearDown(() {
    editAddressBloc.close();
  });

  blocTest(
    'should emit [EditAddressLoading, EditAddressUpdated] when address is updated successfully',
    build: () {
      when(() => mockAddressRepository.updateAddress(mockAddress)).thenAnswer(
        (_) async {},
      );

      return editAddressBloc;
    },
    act: (bloc) => bloc.add(UpdateAddress(mockAddress)),
    expect: () => <EditAddressState>[
      const EditAddressLoading(),
      EditAddressUpdated(mockAddress),
    ],
  );

  blocTest(
    'should emit [EditAddressLoading, EditAddressError] when address is not updated successfully',
    build: () {
      when(() => mockAddressRepository.updateAddress(mockAddress))
          .thenThrow(MockException('Error updating address'));

      return editAddressBloc;
    },
    act: (bloc) => bloc.add(UpdateAddress(mockAddress)),
    expect: () => <EditAddressState>[
      const EditAddressLoading(),
      const EditAddressError('Error updating address'),
    ],
  );
}
