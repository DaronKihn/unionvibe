import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unionvibe/blocs/all_events_bloc/all_events_bloc.dart';
import 'package:unionvibe/blocs/detailed_description_bloc/detailed_description_event_bloc.dart';
import 'package:unionvibe/constants.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';
import 'package:unionvibe/widgets/containerEvent.dart';
import 'screens.dart';

class AllEventsScreen extends StatelessWidget {
  final UserRepository _userRepository;
  const AllEventsScreen({Key? key, required UserRepository userRepository})
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
        title: Text('Выбор занятия'),
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
            create: (context) => AllEventsBloc(userRepository: _userRepository)
              ..add(LoadAllEvents()),
            child: BlocBuilder<AllEventsBloc, AllEventsState>(
                builder: (context, state) {
              if (state is AllEventsLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: kMainColor,
                  ),
                );
              }
              if (state is AllEventsSuccess) {
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
                            return DetailedDescriptionScreen(
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
