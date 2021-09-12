part of 'my_bookings_bloc.dart';

abstract class MyBookingsEvent extends Equatable {
  const MyBookingsEvent();

  @override
  List<Object> get props => [];
}

class LoadAllMyBookedEvents extends MyBookingsEvent {}

class LoadAllMyBookedEventsWithFilters extends MyBookingsEvent {}

class LoadAllMyBookedEventsUpdated extends MyBookingsEvent {
  final List<Event> events;

  const LoadAllMyBookedEventsUpdated(this.events);

  @override
  List<Object> get props => [events];
}
