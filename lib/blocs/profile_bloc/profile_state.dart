part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class DataOfCurrentUserLoading extends ProfileState {}

class DataOfCurrentUserFailure extends ProfileState {}

class DataOfCurrentUserSuccess extends ProfileState {
  final String surname;
  final String name;

  DataOfCurrentUserSuccess(this.surname, this.name);

  @override
  List<Object> get props => [surname, name];
}
