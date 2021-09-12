import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unionvibe/blocs/login_bloc/login_bloc.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';
import 'package:unionvibe/screens/login/login_form.dart';

import '../../constants.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const LoginScreen({required userRepository})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UnionVibe',
        ),
        centerTitle: true,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: kLinearGradient,
              ),
              height: double.infinity,
              width: double.infinity,
            ),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Image(
                    image: AssetImage('images/main_illustration.png'),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: LoginForm(
                      userRepository: _userRepository,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
