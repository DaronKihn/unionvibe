part of 'authentication_bloc.dart';


@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final User firebaseUser;

  AuthenticationSuccess(this.firebaseUser);

  @override
  List<Object> get props => [firebaseUser];
}

class AuthenticationFailure extends AuthenticationState {}