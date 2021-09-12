import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unionvibe/models/event.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';

part 'detailed_description_event_event.dart';
part 'detailed_description_event_state.dart';

class DetailedDescriptionEventBloc
    extends Bloc<DetailedDescriptionEventEvent, DetailedDescriptionEventState> {
  final UserRepository _userRepository;
  DetailedDescriptionEventBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(DetailedDescriptionEventInitial());

  @override
  Stream<DetailedDescriptionEventState> mapEventToState(
    DetailedDescriptionEventEvent event,
  ) async* {
    if (event is LoadDetailedDescription) {
      yield* _mapLoadDetailedDescriptionToState(event);
    }
    if (event is AddParticipant) {
      yield* _mapAddParticipantToState(event);
    }
  }

  Stream<DetailedDescriptionEventState> _mapLoadDetailedDescriptionToState(
      LoadDetailedDescription event) async* {
    yield DetailedDescriptionLoading();
    try {
      final creatorData =
          await _userRepository.getUserData(event.event.creator);
      yield DetailedDescriptionSuccess(event.event,
          creatorData.data()!['surname'], creatorData.data()!['name']);
    } catch (error) {
      print(error);
      yield DetailedDescriptionFailure();
    }
  }

  Stream<DetailedDescriptionEventState> _mapAddParticipantToState(
      AddParticipant event) async* {
    yield AddParticipantLoading();

    try {
      if (event.event.participants.indexOf(_userRepository.getUser().uid) != -1) {
        print(event.event.participants.indexOf(_userRepository.getUser()));
        yield AddParticipantRecordedBefore();
      } else if (event.event.countOfParticipants -
              event.event.participants.length ==
          0) {
        yield AddParticipantNoFreePlaces();
      } else {
        await _userRepository.addParticipant(event.event.eventId);
        yield AddParticipantSuccess();
      }
    } catch (error) {
      print(error);
      yield AddParticipantFailure();
    }
  }
}
