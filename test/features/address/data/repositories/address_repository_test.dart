import 'package:dio/dio.dart';
import 'package:fitwiz/core/services/api_service.dart';
import 'package:fitwiz/features/address/data/models/address.dart';
import 'package:fitwiz/features/address/data/models/pincode.dart';
import 'package:fitwiz/features/address/data/models/society.dart';
import 'package:fitwiz/features/address/data/models/tower.dart';
import 'package:fitwiz/features/address/data/repositories/address_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;
  late AddressRepository addressRepository;

  setUp(() {
    mockApiService = MockApiService();
    addressRepository = AddressRepository(mockApiService);
  });

  group('AddressRepository', () {
    test('should return address with correct pincode, tower, society', () {
      when(() => mockApiService.get('/me/address')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/me/address'),
          data: {
            'name': 'Piyush',
            'pincode': 110001,
            'tower_id': 1,
            'mobile': '1234567890',
            'line_1': 'line 1',
            'line_2': null,
            'landmark': 'something',
          },
        ),
      );

      when(() => mockApiService.get('/pincode/110001')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/pincode/110001'),
          data: {
            'pincode': 110001,
            'city': 'Delhi',
            'state': 'Delhi',
            'country': 'India',
          },
        ),
      );

      when(() => mockApiService.get('/tower/1')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/tower/1'),
          data: {
            'id': 1,
            'name': 'A',
            'society_id': 1,
          },
        ),
      );

      when(() => mockApiService.get('/society/1')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/society/1'),
          data: {
            'id': 1,
            'name': 'B',
          },
        ),
      );

      final address = addressRepository.getAddress();

      expect(
        address,
        completion(
          const Address(
            name: 'Piyush',
            pincode: Pincode(
              pincode: 110001,
              city: 'Delhi',
              state: 'Delhi',
              country: 'India',
            ),
            line1: 'line 1',
            line2: null,
            landmark: 'something',
            mobile: '1234567890',
            tower: Tower(
              id: 1,
              name: 'A',
              society: Society(
                id: 1,
                name: 'B',
              ),
            ),
          ),
        ),
      );
    });

    test('should return societies', () {
      when(() => mockApiService.get('/society',
          queryParams: any(named: 'queryParams'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/society'),
          data: [
            {'id': 1, 'name': 'A'},
            {'id': 2, 'name': 'B'},
          ],
        ),
      );

      final societies = addressRepository.getSocieties();

      expect(
        societies,
        completion(
          [
            const Society(id: 1, name: 'A'),
            const Society(id: 2, name: 'B'),
          ],
        ),
      );
    });

    test('should return towers by society', () {
      when(() => mockApiService.get('/tower/society/1',
          queryParams: any(named: 'queryParams'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/tower/society/1'),
          data: [
            {'id': 1, 'name': 'A'},
            {'id': 2, 'name': 'B'},
          ],
        ),
      );

      final towers = addressRepository.getTowersBySociety(
        const Society(id: 1, name: 'A'),
      );

      expect(
        towers,
        completion(
          [
            const Tower(id: 1, name: 'A', society: Society(id: 1, name: 'A')),
            const Tower(id: 2, name: 'B', society: Society(id: 1, name: 'A')),
          ],
        ),
      );
    });

    test('should update address', () async {
      when(
        () => mockApiService.put(
          '/me/address',
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/me/address'),
          data: {
            'message': 'Address updated successfully',
          },
        ),
      );

      const address = Address(
        name: 'Piyush',
        pincode: Pincode(
          pincode: 110001,
          city: 'Delhi',
          state: 'Delhi',
          country: 'India',
        ),
        line1: 'line 1',
        line2: null,
        landmark: 'something',
        mobile: '1234567890',
        tower: Tower(
          id: 1,
          name: 'A',
          society: Society(
            id: 1,
            name: 'B',
          ),
        ),
      );

      expect(
        addressRepository.updateAddress(address),
        completion(equals(null)),
      );
    });
  });
}
