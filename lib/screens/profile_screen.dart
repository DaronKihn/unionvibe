import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unionvibe/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:unionvibe/blocs/profile_bloc/profile_bloc.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';
import 'package:unionvibe/widgets/button.dart';

import '../constants.dart';

class ProfileScreen extends StatelessWidget {
  final UserRepository _userRepository;
  const ProfileScreen({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: kLinearGradientReversed,
            ),
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocProvider(
                  create: (context) =>
                      ProfileBloc(userRepository: _userRepository)
                        ..add(GetDataOfCurrentUser()),
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is DataOfCurrentUserSuccess) {
                        return Column(
                          children: <Widget>[
                            Text(
                              '${state.surname}',
                              style:
                                  TextStyle(color: kMainColor, fontSize: 20.0),
                            ),
                            Text(
                              '${state.name}',
                              style:
                                  TextStyle(color: kMainColor, fontSize: 20.0),
                            )
                          ],
                        );
                      }
                      return Icon(
                        Icons.person,
                        color: kMainColor,
                        size: 40.0,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Button(
                  width: 200,
                  height: 45,
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(AuthenticationLoggedOut());
                  },
                  text: 'Выйти',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
