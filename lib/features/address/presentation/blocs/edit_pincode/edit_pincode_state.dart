part of 'edit_pincode_bloc.dart';

sealed class EditPincodeState extends Equatable {
  const EditPincodeState();

  @override
  List<Object> get props => [];
}

final class EditPincodeInitial extends EditPincodeState {}

final class EditPincodeLoading extends EditPincodeState {
  const EditPincodeLoading();
}

final class EditPincodeLoaded extends EditPincodeState {
  final Pincode pincode;

  const EditPincodeLoaded(this.pincode);

  @override
  List<Object> get props => [pincode];
}

final class EditPincodeError extends EditPincodeState {
  final String message;

  const EditPincodeError(this.message);

  @override
  List<Object> get props => [message];
}
