import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final UserRepository _userRepository;
  CreateEventBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(CreateEventInitial());

  @override
  Stream<CreateEventState> mapEventToState(
    CreateEventEvent event,
  ) async* {
    if (event is CreateEventSubmitted) {
      yield CreateEventLoading();
      try {
        await _userRepository.addEvent(
            event.typeOfSport,
            event.dateAndTime,
            event.location,
            event.description,
            event.levelOfSkill,
            event.countOfParticipants);
        yield CreateEventSuccess();
      } catch (error) {
        print(error);
        yield CreateEventFailure();
      }
    }
  }
}
