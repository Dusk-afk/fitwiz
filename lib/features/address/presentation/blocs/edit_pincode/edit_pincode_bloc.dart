import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitwiz/features/address/data/models/pincode.dart';
import 'package:fitwiz/features/address/data/repositories/address_repository.dart';

part 'edit_pincode_event.dart';
part 'edit_pincode_state.dart';

class EditPincodeBloc extends Bloc<EditPincodeEvent, EditPincodeState> {
  final AddressRepository _addressRepository;

  EditPincodeBloc(this._addressRepository) : super(EditPincodeInitial()) {
    on<FetchPincode>(_onFetchPincode);
  }

  Future<void> _onFetchPincode(
    FetchPincode event,
    Emitter<EditPincodeState> emit,
  ) async {
    emit(const EditPincodeLoading());
    try {
      final pincode = await _addressRepository.getPincode(event.pincode);
      emit(EditPincodeLoaded(pincode));
    } catch (e) {
      emit(EditPincodeError(e.toString()));
    }
  }
}
