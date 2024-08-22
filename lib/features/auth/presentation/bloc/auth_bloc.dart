import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitwiz/core/setup_locator.dart';
import 'package:fitwiz/features/auth/data/models/register_user_data.dart';
import 'package:fitwiz/features/auth/data/models/user.dart';
import 'package:fitwiz/features/auth/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final AuthRepository _authRepository;

  AuthBloc([AuthRepository? authRepository]) : super(AuthInitial()) {
    _authRepository = authRepository ?? locator.get<AuthRepository>();
    on<AppStarted>(_onAppStarted);
    on<AuthLogin>(_onAuthLogin);
    on<AuthLogout>(_onAuthLogout);
    on<AuthRegister>(_onAuthRegister);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    User? user;
    try {
      user = await _authRepository.fetchFromLocal();
    } catch (e) {
      emit(AuthError(e.toString()));
    }

    if (user != null) {
      emit(AuthLoggedIn(user));
    } else {
      emit(AuthLoggedOut());
    }
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(event.email, event.password);
      emit(AuthLoggedIn(user));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthLoggedOut());
    }
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    final oldState = state;
    emit(AuthLoading());
    try {
      await _authRepository.logout();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(oldState);
    }
  }

  void _onAuthRegister(AuthRegister event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.register(event.data);
      emit(AuthLoggedIn(user));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthLoggedOut());
    }
  }
}
