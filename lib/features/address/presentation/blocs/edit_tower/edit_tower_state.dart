part of 'edit_tower_bloc.dart';

sealed class EditTowerState extends Equatable {
  const EditTowerState();

  @override
  List<Object> get props => [];
}

final class EditTowerInitial extends EditTowerState {}

final class EditTowerLoading extends EditTowerState {
  const EditTowerLoading();
}

final class EditTowerLoaded extends EditTowerState {
  final List<TowerShort> towers;

  const EditTowerLoaded(this.towers);

  @override
  List<Object> get props => [towers];
}

final class EditTowerError extends EditTowerState {
  final String message;

  const EditTowerError(this.message);

  @override
  List<Object> get props => [message];
}
