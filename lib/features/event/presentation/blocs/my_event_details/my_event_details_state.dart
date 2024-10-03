part of 'my_event_details_bloc.dart';

class MyEventDetailsState extends Equatable {
  final bool isLoading;
  final String? loadingMessage;

  final bool isUpdating;
  final String? updatingMessage;

  final String? errorMessage;

  final Event? event;
  final EventTeam? eventTeam;

  const MyEventDetailsState({
    this.isLoading = false,
    this.loadingMessage,
    this.isUpdating = false,
    this.updatingMessage,
    this.errorMessage,
    this.event,
    this.eventTeam,
  });

  @override
  List<Object> get props => [
        isLoading,
        loadingMessage ?? '',
        isUpdating,
        updatingMessage ?? '',
        errorMessage ?? '',
        event ?? '',
        eventTeam ?? ''
      ];

  MyEventDetailsState copyWith({
    bool? isLoading,
    Nullable<String>? loadingMessage,
    bool? isUpdating,
    Nullable<String>? updatingMessage,
    Nullable<String>? errorMessage,
    Nullable<Event>? event,
    Nullable<EventTeam>? eventTeam,
  }) {
    return MyEventDetailsState(
      isLoading: isLoading ?? this.isLoading,
      loadingMessage:
          loadingMessage == null ? this.loadingMessage : loadingMessage.value,
      isUpdating: isUpdating ?? this.isUpdating,
      updatingMessage: updatingMessage == null
          ? this.updatingMessage
          : updatingMessage.value,
      errorMessage:
          errorMessage == null ? this.errorMessage : errorMessage.value,
      event: event == null ? this.event : event.value,
      eventTeam: eventTeam == null ? this.eventTeam : eventTeam.value,
    );
  }
}

// final class MyEventDetailsLoading extends MyEventDetailsState {}

// final class MyEventDetailsUpdating extends MyEventDetailsLoading {
//   final String message;

//   MyEventDetailsUpdating({
//     required this.message,
//   });

//   @override
//   List<Object> get props => [message];
// }

// final class MyEventDetailsUpdatingFinished extends MyEventDetailsLoading {
//   final String? errorMessage;

//   MyEventDetailsUpdatingFinished({
//     this.errorMessage,
//   });

//   @override
//   List<Object> get props => [errorMessage ?? ''];
// }

// final class MyEventDetailsSuccess extends MyEventDetailsState {
//   final Event event;
//   final EventTeam? eventTeam;

//   const MyEventDetailsSuccess({
//     required this.event,
//     required this.eventTeam,
//   });

//   @override
//   List<Object> get props => [event, eventTeam ?? ''];
// }

// final class MyEventDetailsError extends MyEventDetailsState {
//   final String message;

//   const MyEventDetailsError({
//     required this.message,
//   });

//   @override
//   List<Object> get props => [message];
// }
