part of 'edit_tower_bloc.dart';

sealed class EditTowerEvent extends Equatable {
  const EditTowerEvent();

  @override
  List<Object> get props => [];
}

final class FetchTowers extends EditTowerEvent {
  final Society society;

  const FetchTowers(this.society);

  @override
  List<Object> get props => [society];
}
