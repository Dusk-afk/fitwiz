import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitwiz/features/address/data/models/address.dart';
import 'package:fitwiz/features/address/data/repositories/address_repository.dart';

part 'edit_address_event.dart';
part 'edit_address_state.dart';

class EditAddressBloc extends Bloc<EditAddressEvent, EditAddressState> {
  final AddressRepository _addressRepository;

  EditAddressBloc(this._addressRepository) : super(EditAddressInitial()) {
    on<UpdateAddress>(_onUpdateAddress);
  }

  Future<void> _onUpdateAddress(
    UpdateAddress event,
    Emitter<EditAddressState> emit,
  ) async {
    emit(const EditAddressLoading());
    try {
      await _addressRepository.updateAddress(event.address);
      emit(EditAddressUpdated(event.address));
    } catch (e) {
      emit(EditAddressError(e.toString()));
    }
  }
}
