import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unionvibe/models/event.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';

part 'my_booking_detailed_event.dart';
part 'my_booking_detailed_state.dart';

class MyBookingDetailedBloc
    extends Bloc<MyBookingDetailedEvent, MyBookingDetailedState> {
  final UserRepository _userRepository;
  MyBookingDetailedBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(MyBookingDetailedInitial());

  @override
  Stream<MyBookingDetailedState> mapEventToState(
    MyBookingDetailedEvent event,
  ) async* {
    if (event is LoadBookingDetailed) {
      yield* _mapLoadDetailedDescriptionToState(event);
    }
  }

  Stream<MyBookingDetailedState> _mapLoadDetailedDescriptionToState(
      LoadBookingDetailed event) async* {
    yield MyBookingDetailedLoading();
    try {
      final creatorData =
          await _userRepository.getUserData(event.event.creator);
      yield MyBookingDetailedSuccess(event.event,
          creatorData.data()!['surname'], creatorData.data()!['name']);
    } catch (error) {
      print(error);
      yield MyBookingDetailedFailure();
    }
  }
}
