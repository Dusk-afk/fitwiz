import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitwiz/features/event/data/repositories/event_repository.dart';

part 'event_register_event.dart';
part 'event_register_state.dart';

class EventRegisterBloc extends Bloc<EventRegisterEvent, EventRegisterState> {
  late final EventRepository _eventRepository;

  EventRegisterBloc(this._eventRepository) : super(EventRegisterInitial()) {
    on<RegisterEvent>(_onRegisterEvent);
  }

  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<EventRegisterState> emit) async {
    emit(EventRegisterLoading());
    try {
      final ticketNumber = await _eventRepository.createOrder(event.eventId);
      emit(EventRegisterSuccess(ticketNumber));
    } catch (e) {
      emit(EventRegisterError(e.toString()));
    }
  }
}
