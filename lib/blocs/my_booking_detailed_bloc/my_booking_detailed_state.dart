part of 'my_booking_detailed_bloc.dart';

abstract class MyBookingDetailedState extends Equatable {
  const MyBookingDetailedState();

  @override
  List<Object> get props => [];
}

class MyBookingDetailedInitial extends MyBookingDetailedState {}

class MyBookingDetailedSuccess extends MyBookingDetailedState {
  final Event event;
  final String creatorSurname;
  final String creatorName;

  MyBookingDetailedSuccess(this.event, this.creatorName, this.creatorSurname);

  @override
  List<Object> get props => [event, creatorSurname, creatorName];
}

class MyBookingDetailedFailure extends MyBookingDetailedState {}

class MyBookingDetailedLoading extends MyBookingDetailedState {}
