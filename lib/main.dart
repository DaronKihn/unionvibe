import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unionvibe/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';
import 'screens/screens.dart';
import 'constants.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AuthenticationStarted()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: kMainColor,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationFailure) {
              return LoginScreen(userRepository: userRepository);
            }
            if (state is AuthenticationSuccess) {
              return HomeScreen(userRepository: userRepository,);
            }
            return Scaffold(
              appBar: AppBar(),
              body: Container(
                child: Center(child: Text("Loading")),
              ),
            );
          },
        ),
      ),
    );
  }
}
