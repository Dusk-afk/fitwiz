part of 'edit_address_bloc.dart';

sealed class EditAddressEvent extends Equatable {
  const EditAddressEvent();

  @override
  List<Object> get props => [];
}

final class UpdateAddress extends EditAddressEvent {
  final Address address;

  const UpdateAddress(this.address);

  @override
  List<Object> get props => [address];
}
