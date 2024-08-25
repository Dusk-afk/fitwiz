import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitwiz/features/address/data/models/society.dart';
import 'package:fitwiz/features/address/data/models/tower_short.dart';
import 'package:fitwiz/features/address/data/repositories/address_repository.dart';

part 'edit_tower_event.dart';
part 'edit_tower_state.dart';

class EditTowerBloc extends Bloc<EditTowerEvent, EditTowerState> {
  final AddressRepository _addressRepository;

  EditTowerBloc(this._addressRepository) : super(EditTowerInitial()) {
    on<FetchTowers>(_onFetchTowers);
  }

  Future<void> _onFetchTowers(
    FetchTowers event,
    Emitter<EditTowerState> emit,
  ) async {
    emit(const EditTowerLoading());
    try {
      final towers = await _addressRepository.getTowersBySociety(event.society);
      final towerShorts =
          towers.map((tower) => TowerShort.fromTower(tower)).toList();
      emit(EditTowerLoaded(towerShorts));
    } catch (e) {
      emit(EditTowerError(e.toString()));
    }
  }
}
