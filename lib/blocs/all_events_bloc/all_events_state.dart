part of 'all_events_bloc.dart';

abstract class AllEventsState extends Equatable {
  const AllEventsState();

  @override
  List<Object> get props => [];
}

class AllEventsInitial extends AllEventsState {}

class AllEventsSuccess extends AllEventsState {
  final List<Event> events;

  AllEventsSuccess(this.events);

  @override
  List<Object> get props => [events];
}

class AllEventsFailure extends AllEventsState {}

class AllEventsLoading extends AllEventsState {}
