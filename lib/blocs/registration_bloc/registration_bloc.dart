import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';
import 'package:unionvibe/utils/validators.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final UserRepository _userRepository;
  RegistrationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegistrationState.initial());

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is RegistrationChanged) {
      yield* _mapRegistrationChangedToState(
          email: event.email, password: event.password);
    } else if (event is RegistrationSubmitted) {
      yield* _mapRegistrationSubmittedToState(
          email: event.email,
          password: event.password,
          surname: event.surname,
          name: event.name);
    }
  }

  Stream<RegistrationState> _mapRegistrationChangedToState(
      {required String email, required String password}) async* {
    yield state.update(
        isEmailValid: Validators.isValidEmail(email),
        isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegistrationState> _mapRegistrationSubmittedToState(
      {required String email,
      required String password,
      required String surname,
      required String name}) async* {
    yield RegistrationState.loading();
    try {
      await _userRepository.signUp(email, password);
      await _userRepository.addUser(surname, name);
      yield RegistrationState.success();
    } catch (error) {
      print(error);
      yield RegistrationState.failure();
    }
  }
}
