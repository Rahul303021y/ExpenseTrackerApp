import 'package:flutter_bloc/flutter_bloc.dart';

import '../login_data/login_repo.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<LoginButtonPressedEvent>(_login);
  }

  Future<void> _login(
      LoginButtonPressedEvent event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());

    try {
      final user = await repository.login(
        email: event.email,
        password: event.password,
        deviceId: event.deviceId,
        deviceName: event.deviceName,
      );

      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}