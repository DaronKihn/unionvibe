part of 'my_booking_detailed_bloc.dart';

abstract class MyBookingDetailedEvent extends Equatable {
  const MyBookingDetailedEvent();

  @override
  List<Object> get props => [];
}

class LoadBookingDetailed extends MyBookingDetailedEvent {
  final Event event;

  const LoadBookingDetailed(this.event);

  @override
  List<Object> get props => [event];
}