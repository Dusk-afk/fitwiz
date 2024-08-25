part of 'edit_society_bloc.dart';

sealed class EditSocietyState extends Equatable {
  const EditSocietyState();

  @override
  List<Object> get props => [];
}

final class EditSocietyInitial extends EditSocietyState {}

final class EditSocietyLoading extends EditSocietyState {
  const EditSocietyLoading();
}

final class EditSocietyLoaded extends EditSocietyState {
  final List<Society> societies;

  const EditSocietyLoaded(this.societies);

  @override
  List<Object> get props => [societies];
}

final class EditSocietyError extends EditSocietyState {
  final String message;

  const EditSocietyError(this.message);

  @override
  List<Object> get props => [message];
}
