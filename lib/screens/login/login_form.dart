import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unionvibe/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:unionvibe/blocs/login_bloc/login_bloc.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';
import 'package:unionvibe/screens/registration/registration_screen.dart';
import 'package:unionvibe/widgets/button.dart';

import '../../constants.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;
  const LoginForm({required userRepository}) : _userRepository = userRepository;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late LoginBloc _loginBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onChange);
    _passwordController.addListener(_onChange);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Не удалось войти'),
                  Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        }
        if (state.isSubmitting) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Вход в личный кабинет'),
                CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          ));
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationLoggedIn(),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(
              20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: kMainColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: kMainColor,
                    )),
                    icon: Icon(
                      Icons.email,
                      color: kMainColor,
                    ),
                  ),
                  cursorColor: kMainColor,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isEmailValid ? 'Некорректный Email' : null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Пароль',
                    labelStyle: TextStyle(
                      color: kMainColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: kMainColor,
                    )),
                    icon: Icon(
                      Icons.lock,
                      color: kMainColor,
                    ),
                  ),
                  cursorColor: kMainColor,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isPasswordValid
                        ? 'Некорректный пароль'
                        : null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Button(
                  width: 200,
                  height: 45,
                  onPressed: () {
                    if (isButtonEnabled(state)) {
                      _onFormSubmitted();
                    }
                  },
                  text: 'Войти',
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('Нет личного кабинета?'),
                SizedBox(
                  height: 10.0,
                ),
                Button(
                  width: 200,
                  height: 45,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return RegistrationScreen(
                          userRepository: widget._userRepository);
                    }));
                  },
                  text: 'Зарегистрироваться',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onChange() {
    _loginBloc.add(LoginChanged(
        email: _emailController.text, password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginSubmitted(
        email: _emailController.text, password: _passwordController.text));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
