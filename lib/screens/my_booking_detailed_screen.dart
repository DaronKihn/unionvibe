import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unionvibe/blocs/my_booking_detailed_bloc/my_booking_detailed_bloc.dart';
import 'package:unionvibe/constants.dart';
import 'package:unionvibe/models/event.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';

class MyBookingDetailedScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final Event _event;
  const MyBookingDetailedScreen({
    Key? key,
    required Event event,
    required UserRepository userRepository,
  })  : _event = event,
        _userRepository = userRepository,
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

  Widget columnWithTextAndIcon(String text, IconData icon) {
    return Center(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                color: kMainColor,
                fontSize: 16.0,
              ),
            ),
            Icon(
              icon,
              color: kMainColor,
              size: 40.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Подробное описание'),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: kLinearGradient,
              ),
            ),
            BlocProvider(
              create: (context) =>
                  MyBookingDetailedBloc(userRepository: _userRepository)
                    ..add(LoadBookingDetailed(_event)),
              child: BlocBuilder<MyBookingDetailedBloc, MyBookingDetailedState>(
                builder: (context, state) {
                  if (state is MyBookingDetailedFailure) {
                    return columnWithTextAndIcon(
                      'Не удалось загрузить данные',
                      Icons.error,
                    );
                  }
                  if (state is MyBookingDetailedLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kMainColor,
                      ),
                    );
                  }
                  if (state is MyBookingDetailedSuccess) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            iconWithText(Icons.person,
                                '${state.creatorSurname} ${state.creatorName}'),
                            iconWithText(
                                Icons.directions_bike, _event.typeOfSport),
                            iconWithText(Icons.trending_up,
                                'Уровень: ${_event.levelOfSkill.toLowerCase()}'),
                            iconWithText(Icons.location_on, _event.location),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Описание:',
                                  style: TextStyle(
                                      color: kMainColor,
                                      fontSize: 18.0,
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    _event.description,
                                    style: TextStyle(
                                        color: kMainColor, fontSize: 17.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Количество свободных мест: ${_event.countOfParticipants - _event.participants.length}/${_event.countOfParticipants}',
                                    style: TextStyle(
                                        color: kMainColor, fontSize: 17.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    '${_event.date} ${_event.time}',
                                    style: TextStyle(
                                        color: kMainColor, fontSize: 16.0),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: kMainColor,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
