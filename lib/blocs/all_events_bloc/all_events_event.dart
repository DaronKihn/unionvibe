part of 'all_events_bloc.dart';

abstract class AllEventsEvent extends Equatable {
  const AllEventsEvent();

  @override
  List<Object> get props => [];
}

class LoadAllEvents extends AllEventsEvent {}

class LoadAllEventsWithFilters extends AllEventsEvent {}

class LoadAllEventsUpdated extends AllEventsEvent {
  final List<Event> events;

  const LoadAllEventsUpdated(this.events);

  @override
  List<Object> get props => [events];
}

