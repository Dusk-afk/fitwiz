import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitwiz/features/address/data/models/address.dart';
import 'package:fitwiz/features/address/data/repositories/address_repository.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository _addressRepository;

  AddressBloc(this._addressRepository, [AddressState? initialState])
      : super(initialState ?? AddressInitial()) {
    on<FetchAddress>(_onFetchAddress);
    on<UpdateAddess>(_onUpdateAddess);
  }

  Future<void> _onFetchAddress(
    FetchAddress event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddressLoading());
    try {
      final address = await _addressRepository.getAddress();
      emit(AddressLoaded(address));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> _onUpdateAddess(
    UpdateAddess event,
    Emitter<AddressState> emit,
  ) async {
    if (state is! AddressLoaded) {
      return;
    }

    emit(AddressLoaded(event.address));
  }
}
