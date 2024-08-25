import 'package:fitwiz/core/services/api_service.dart';
import 'package:fitwiz/features/address/data/models/address.dart';
import 'package:fitwiz/features/address/data/models/pincode.dart';
import 'package:fitwiz/features/address/data/models/society.dart';
import 'package:fitwiz/features/address/data/models/tower.dart';

class AddressRepository {
  final ApiService _apiService;

  AddressRepository(this._apiService);

  Future<Address?> getAddress() async {
    final addressResponse = await _apiService.get('/me/address');
    final Map<String, dynamic>? addressData = addressResponse.data;
    if (addressData == null || addressData.isEmpty) {
      return null;
    }

    final pincode = await getPincode(addressData['pincode']);
    final tower = await getTower(addressData['tower_id']);
    return Address.fromJsonPincodeTower(addressData, pincode, tower);
  }

  Future<Pincode> getPincode(int pincode) async {
    final pincodeResponse = await _apiService.get('/pincode/$pincode');
    return Pincode.fromJson(pincodeResponse.data);
  }

  Future<Tower> getTower(int towerId) async {
    final towerResponse = await _apiService.get('/tower/$towerId');
    final Map<String, dynamic> towerData = towerResponse.data;
    final society = await getSociety(towerData['society_id']);
    return Tower.fromJsonSociety(towerData, society);
  }

  Future<Society> getSociety(int societyId) async {
    final societyResponse = await _apiService.get('/society/$societyId');
    return Society.fromJson(societyResponse.data);
  }

  Future<List<Society>> getSocieties({int page = 1, int pageSize = 100}) async {
    final societyResponse = await _apiService.get('/society', queryParams: {
      'page': page,
      'page_size': pageSize,
    });
    final List<dynamic> societyData = societyResponse.data;
    return societyData.map((society) => Society.fromJson(society)).toList();
  }

  Future<List<Tower>> getTowersBySociety(
    Society society, {
    int page = 1,
    int pageSize = 100,
  }) async {
    final towerResponse =
        await _apiService.get('/tower/society/${society.id}', queryParams: {
      'page': page,
      'page_size': pageSize,
    });
    final List<dynamic> towerData = towerResponse.data;
    return towerData
        .map((tower) => Tower.fromJsonSociety(tower, society))
        .toList();
  }

  Future<void> updateAddress(Address address) async {
    await _apiService.put('/me/address', data: address.toUpdateJson());
  }
}
