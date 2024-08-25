import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitwiz/features/address/data/models/society.dart';
import 'package:fitwiz/features/address/data/repositories/address_repository.dart';

part 'edit_society_event.dart';
part 'edit_society_state.dart';

class EditSocietyBloc extends Bloc<EditSocietyEvent, EditSocietyState> {
  final AddressRepository _addressRepository;

  EditSocietyBloc(this._addressRepository) : super(EditSocietyInitial()) {
    on<FetchSocieties>(_onFetchSocieties);
  }

  Future<void> _onFetchSocieties(
    FetchSocieties event,
    Emitter<EditSocietyState> emit,
  ) async {
    emit(const EditSocietyLoading());
    try {
      final societies = await _addressRepository.getSocieties();
      emit(EditSocietyLoaded(societies));
    } catch (e) {
      emit(EditSocietyError(e.toString()));
    }
  }
}
