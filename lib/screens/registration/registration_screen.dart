import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unionvibe/blocs/registration_bloc/registration_bloc.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';
import 'package:unionvibe/screens/registration/registration_form.dart';
import '../../constants.dart';

class RegistrationScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const RegistrationScreen({required userRepository})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Регистрация',
        ),
        centerTitle: true,
      ),
      body: BlocProvider<RegistrationBloc>(
        create: (context) => RegistrationBloc(userRepository: _userRepository),
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
                    child: RegistrationForm(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
