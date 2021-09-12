import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unionvibe/blocs/my_bookings_bloc/my_bookings_bloc.dart';
import 'package:unionvibe/constants.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';
import 'package:unionvibe/screens/screens.dart';
import 'package:unionvibe/widgets/containerEvent.dart';

class MyBookingsScreen extends StatelessWidget {
  final UserRepository _userRepository;
  const MyBookingsScreen({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  Widget iconWithText(IconData icon, String text) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: kMainColor,
        ),
        SizedBox(
          width: 5.0,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: kMainColor, fontSize: 18.0),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мои записи'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: kLinearGradient,
            ),
            height: double.infinity,
            width: double.infinity,
          ),
          BlocProvider(
            create: (context) => MyBookingsBloc(userRepository: _userRepository)
              ..add(LoadAllMyBookedEvents()),
            child: BlocBuilder<MyBookingsBloc, MyBookingsState>(
                builder: (context, state) {
              if (state is MyBookingsLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: kMainColor,
                  ),
                );
              }
              if (state is MyBookingsSuccess) {
                return ListView.builder(
                  itemCount: state.events.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: ContainerEvent(
                        event: state.events[index],
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return MyBookingDetailedScreen(
                              event: state.events[index],
                              userRepository: _userRepository,
                            );
                          }));
                        },
                        titleButton: 'Подробнее',
                      ),
                    );
                  },
                );
              }
              return Center(
                child: Text("Loading"),
              );
            }),
          ),
        ],
      ),
    );
  }
}
