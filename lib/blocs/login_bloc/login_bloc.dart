import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';
import 'package:unionvibe/utils/validators.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  
  final UserRepository _userRepository;
  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginChanged) {
      yield* _mapLoginChangedToState(
          email: event.email, password: event.password);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<LoginState> _mapLoginChangedToState(
      {required String email, required String password}) async* {
    yield state.update(
        isEmailValid: Validators.isValidEmail(email),
        isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<LoginState> _mapLoginSubmittedToState(
      {required String email, required String password}) async* {
        yield LoginState.loading();
        try {
          await _userRepository.signInWithCredentials(email, password);
          yield LoginState.success();
        }
        catch (error){
          print(error);
          yield LoginState.failure();
        }
      }
}
