part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginChanged extends LoginEvent {
  final String email;
  final String password;

  LoginChanged({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}