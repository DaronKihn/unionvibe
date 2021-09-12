part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationChanged extends RegistrationEvent {
  final String email;
  final String password;

  RegistrationChanged({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegistrationSubmitted extends RegistrationEvent {
  final String email;
  final String password;
  final String surname;
  final String name;

  RegistrationSubmitted({
    required this.email,
    required this.password,
    required this.surname,
    required this.name,
  });

  @override
  List<Object> get props => [email, password, surname, name];
}
