import 'package:bloc_test/bloc_test.dart';
import 'package:fitwiz/features/address/data/models/pincode.dart';
import 'package:fitwiz/features/address/data/repositories/address_repository.dart';
import 'package:fitwiz/features/address/presentation/blocs/edit_pincode/edit_pincode_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../auth/presentation/bloc/auth_bloc_test.dart';

class MockAddressRepository extends Mock implements AddressRepository {}

class MockPincode extends Mock implements Pincode {}

void main() {
  late MockAddressRepository mockAddressRepository;
  late MockPincode mockPincode;
  late EditPincodeBloc editPincodeBloc;

  setUp(() {
    mockAddressRepository = MockAddressRepository();
    mockPincode = MockPincode();
    editPincodeBloc = EditPincodeBloc(mockAddressRepository);
  });

  tearDown(() {
    editPincodeBloc.close();
  });

  blocTest(
    'should emit [EditPincodeLoading, EditPincodeLoaded] when pincode is fetched successfully',
    build: () {
      when(() => mockAddressRepository.getPincode(123456)).thenAnswer(
        (_) async => mockPincode,
      );

      return editPincodeBloc;
    },
    act: (bloc) => bloc.add(const FetchPincode(123456)),
    expect: () => <EditPincodeState>[
      const EditPincodeLoading(),
      EditPincodeLoaded(mockPincode),
    ],
  );

  blocTest(
    'should emit [EditPincodeLoading, EditPincodeError] when pincode is not fetched successfully',
    build: () {
      when(() => mockAddressRepository.getPincode(123456))
          .thenThrow(MockException('Error fetching pincode'));

      return editPincodeBloc;
    },
    act: (bloc) => bloc.add(const FetchPincode(123456)),
    expect: () => <EditPincodeState>[
      const EditPincodeLoading(),
      const EditPincodeError('Error fetching pincode'),
    ],
  );
}
