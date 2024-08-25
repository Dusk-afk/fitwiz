part of 'edit_pincode_bloc.dart';

sealed class EditPincodeEvent extends Equatable {
  const EditPincodeEvent();

  @override
  List<Object> get props => [];
}

final class FetchPincode extends EditPincodeEvent {
  final int pincode;

  const FetchPincode(this.pincode);

  @override
  List<Object> get props => [pincode];
}
