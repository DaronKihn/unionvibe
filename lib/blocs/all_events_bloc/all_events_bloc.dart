import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unionvibe/models/event.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';

part 'all_events_event.dart';
part 'all_events_state.dart';

class AllEventsBloc extends Bloc<AllEventsEvent, AllEventsState> {
  final UserRepository _userRepository;
  StreamSubscription? _eventStreamSubscription;
  AllEventsBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AllEventsLoading());

  @override
  Stream<AllEventsState> mapEventToState(
    AllEventsEvent event,
  ) async* {
    if (event is LoadAllEvents) {
      yield* _mapLoadAllEventsToState();
    } else if (event is LoadAllEventsUpdated) {
      yield* _mapLoadAllEventsUpdatedToState(event);
    }
  }

  Stream<AllEventsState> _mapLoadAllEventsToState() async* {
    _eventStreamSubscription?.cancel();
    _eventStreamSubscription = _userRepository.events().listen(
      (events) {
        add(
          LoadAllEventsUpdated(events),
        );
      },
    );
  }

  Stream<AllEventsState> _mapLoadAllEventsUpdatedToState(
      LoadAllEventsUpdated event) async* {
    yield AllEventsSuccess(event.events);
  }

  @override
  Future<void> close() {
    _eventStreamSubscription?.cancel();
    return super.close();
  }
}
