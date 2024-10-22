part of 'address_bloc.dart';

sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

final class FetchAddress extends AddressEvent {}

final class UpdateAddess extends AddressEvent {
  final Address address;

  const UpdateAddess(this.address);

  @override
  List<Object> get props => [address];
}
