part of 'edit_society_bloc.dart';

sealed class EditSocietyEvent extends Equatable {
  const EditSocietyEvent();

  @override
  List<Object> get props => [];
}

final class FetchSocieties extends EditSocietyEvent {}
