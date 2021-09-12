import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unionvibe/models/event.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';

part 'my_bookings_event.dart';
part 'my_bookings_state.dart';

class MyBookingsBloc extends Bloc<MyBookingsEvent, MyBookingsState> {
  final UserRepository _userRepository;
  StreamSubscription? _eventStreamSubscription;
  MyBookingsBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(MyBookingsLoading());

  @override
  Stream<MyBookingsState> mapEventToState(
    MyBookingsEvent event,
  ) async* {
    if (event is LoadAllMyBookedEvents) {
      yield* _mapLoadAllMyBookedEventsToState();
    } else if (event is LoadAllMyBookedEventsUpdated) {
      yield* _mapLoadAllMyBookedEventsUpdatedToState(event);
    }
  }

  Stream<MyBookingsState> _mapLoadAllMyBookedEventsToState() async* {
    _eventStreamSubscription?.cancel();
    _eventStreamSubscription = _userRepository.myBookedEvents().listen(
      (events) {
        add(
          LoadAllMyBookedEventsUpdated(events),
        );
      },
    );
  }

  Stream<MyBookingsState> _mapLoadAllMyBookedEventsUpdatedToState(
      LoadAllMyBookedEventsUpdated event) async* {
    yield MyBookingsSuccess(event.events);
  }

  @override
  Future<void> close() {
    _eventStreamSubscription?.cancel();
    return super.close();
  }
}
