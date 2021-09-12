part of 'create_event_bloc.dart';

abstract class CreateEventEvent extends Equatable {
  const CreateEventEvent();

  @override
  List<Object> get props => [];
}

class CreateEventSubmitted extends CreateEventEvent {
  final typeOfSport;
  final String dateAndTime;
  final String location;
  final String description;
  final levelOfSkill;
  final String countOfParticipants;

  CreateEventSubmitted({
    required this.typeOfSport,
    required this.dateAndTime,
    required this.location,
    required this.description,
    required this.levelOfSkill,
    required this.countOfParticipants,
  });

  @override
  List<Object> get props => [
        typeOfSport,
        dateAndTime,
        location,
        description,
        levelOfSkill,
        countOfParticipants,
      ];
}
