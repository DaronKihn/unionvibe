part of 'detailed_description_event_bloc.dart';

abstract class DetailedDescriptionEventEvent extends Equatable {
  const DetailedDescriptionEventEvent();

  @override
  List<Object> get props => [];
}

class LoadDetailedDescription extends DetailedDescriptionEventEvent {
  final Event event;

  const LoadDetailedDescription(this.event);

  @override
  List<Object> get props => [event];
}

class AddParticipant extends DetailedDescriptionEventEvent {
  final Event event;

  const AddParticipant(this.event);

  @override
  List<Object> get props => [event];
}
