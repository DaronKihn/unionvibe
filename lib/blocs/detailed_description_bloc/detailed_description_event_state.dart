part of 'detailed_description_event_bloc.dart';

abstract class DetailedDescriptionEventState extends Equatable {
  const DetailedDescriptionEventState();

  @override
  List<Object> get props => [];
}

class DetailedDescriptionEventInitial extends DetailedDescriptionEventState {}

class DetailedDescriptionSuccess extends DetailedDescriptionEventState {
  final Event event;
  final String creatorSurname;
  final String creatorName;

  DetailedDescriptionSuccess(this.event, this.creatorName, this.creatorSurname);

  @override
  List<Object> get props => [event, creatorSurname, creatorName];
}

class DetailedDescriptionFailure extends DetailedDescriptionEventState {}

class DetailedDescriptionLoading extends DetailedDescriptionEventState {}

class AddParticipantSuccess extends DetailedDescriptionEventState {}

class AddParticipantFailure extends DetailedDescriptionEventState {}

class AddParticipantLoading extends DetailedDescriptionEventState {}

class AddParticipantNoFreePlaces extends DetailedDescriptionEventState {}

class AddParticipantRecordedBefore extends DetailedDescriptionEventState {}
