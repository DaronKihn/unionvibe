part of 'my_bookings_bloc.dart';

abstract class MyBookingsState extends Equatable {
  const MyBookingsState();

  @override
  List<Object> get props => [];
}

class MyBookingsInitial extends MyBookingsState {}

class MyBookingsSuccess extends MyBookingsState {
  final List<Event> events;

  MyBookingsSuccess(this.events);

  @override
  List<Object> get props => [events];
}

class MyBookingsFailure extends MyBookingsState {}

class MyBookingsLoading extends MyBookingsState {}
