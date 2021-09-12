import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  ProfileBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is GetDataOfCurrentUser) {
      yield* _mapGetDataOfCurrentUserToState();
    }
  }

  Stream<ProfileState> _mapGetDataOfCurrentUserToState() async* {
    yield DataOfCurrentUserLoading();
    try {
      final userData =
          await _userRepository.getUserData(_userRepository.getUser().uid);
      yield DataOfCurrentUserSuccess(
          userData.data()!['surname'], userData.data()!['name']);
    } catch (error) {
      print(error);
      yield DataOfCurrentUserFailure();
    }
  }
}
