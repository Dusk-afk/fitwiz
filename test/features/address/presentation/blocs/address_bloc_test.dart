import 'package:bloc_test/bloc_test.dart';
import 'package:fitwiz/features/address/data/models/address.dart';
import 'package:fitwiz/features/address/data/repositories/address_repository.dart';
import 'package:fitwiz/features/address/presentation/blocs/address/address_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../auth/presentation/bloc/auth_bloc_test.dart';

class MockAddressRepository extends Mock implements AddressRepository {}

class MockAddress extends Mock implements Address {}

void main() {
  late MockAddressRepository mockAddressRepository;
  late MockAddress mockAddress;
  late AddressBloc addressBloc;
  late AddressBloc addressBlocLoaded;

  setUp(() {
    mockAddressRepository = MockAddressRepository();
    mockAddress = MockAddress();
    addressBloc = AddressBloc(mockAddressRepository);
    addressBlocLoaded =
        AddressBloc(mockAddressRepository, AddressLoaded(mockAddress));
  });

  tearDown(() {
    addressBloc.close();
  });

  blocTest(
    'should emit [AddressLoading, AddressLoaded] when address is fetched successfully',
    build: () {
      when(() => mockAddressRepository.getAddress()).thenAnswer(
        (_) async => mockAddress,
      );

      return addressBloc;
    },
    act: (bloc) => bloc.add(FetchAddress()),
    expect: () => <AddressState>[
      AddressLoading(),
      AddressLoaded(mockAddress),
    ],
  );

  blocTest(
    'should emit [AddressLoading, AddressError] when address is not fetched successfully',
    build: () {
      when(() => mockAddressRepository.getAddress())
          .thenThrow(MockException('Error fetching address'));

      return addressBloc;
    },
    act: (bloc) => bloc.add(FetchAddress()),
    expect: () => <AddressState>[
      AddressLoading(),
      const AddressError('Error fetching address'),
    ],
  );

  blocTest(
    'should emit nothing when state is not AddressLoaded on UpdateAddress event',
    build: () => addressBloc,
    act: (bloc) => bloc.add(UpdateAddess(mockAddress)),
    expect: () => <AddressState>[],
  );

  blocTest(
    'should emit [AddressLoaded] when state is AddressLoaded on UpdateAddress event',
    build: () => addressBlocLoaded,
    act: (bloc) => bloc.add(UpdateAddess(mockAddress)),
    expect: () => <AddressState>[AddressLoaded(mockAddress)],
  );
}
