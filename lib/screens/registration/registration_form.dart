import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unionvibe/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:unionvibe/blocs/registration_bloc/registration_bloc.dart';
import '../../constants.dart';
import '../../widgets/button.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  late RegistrationBloc _registrationBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _surnameController.text.isNotEmpty &&
      _nameController.text.isNotEmpty;

  bool isButtonEnabled(RegistrationState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    _emailController.addListener(_onChange);
    _passwordController.addListener(_onChange);

    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Не удалось зарегистрироваться'),
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
                Text('Регистрация'),
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
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(
              20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _surnameController,
                  decoration: InputDecoration(
                    labelText: 'Фамилия',
                    labelStyle: TextStyle(
                      color: kMainColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: kMainColor,
                    )),
                    icon: Icon(
                      Icons.person,
                      color: kMainColor,
                    ),
                  ),
                  cursorColor: kMainColor,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  validator: (_) {
                    return _surnameController.text.isEmpty
                        ? 'Пустое поле'
                        : null;
                  },
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Имя',
                    labelStyle: TextStyle(
                      color: kMainColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: kMainColor,
                    )),
                    icon: Icon(
                      Icons.person,
                      color: kMainColor,
                    ),
                  ),
                  cursorColor: kMainColor,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  validator: (_) {
                    return _nameController.text.isEmpty ? 'Пустое поле' : null;
                  },
                ),
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
    _registrationBloc.add(RegistrationChanged(
        email: _emailController.text, password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _registrationBloc.add(RegistrationSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
        surname: _surnameController.text,
        name: _nameController.text));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _surnameController.dispose();
    _nameController.dispose();
  }
}
