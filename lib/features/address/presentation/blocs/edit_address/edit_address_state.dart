part of 'edit_address_bloc.dart';

sealed class EditAddressState extends Equatable {
  const EditAddressState();

  @override
  List<Object> get props => [];
}

final class EditAddressInitial extends EditAddressState {}

final class EditAddressLoading extends EditAddressState {
  const EditAddressLoading();
}

final class EditAddressUpdated extends EditAddressState {
  final Address address;

  const EditAddressUpdated(this.address);

  @override
  List<Object> get props => [address];
}

final class EditAddressError extends EditAddressState {
  final String message;

  const EditAddressError(this.message);

  @override
  List<Object> get props => [message];
}
