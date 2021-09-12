import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unionvibe/blocs/detailed_description_bloc/detailed_description_event_bloc.dart';
import 'package:unionvibe/constants.dart';
import 'package:unionvibe/models/event.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';
import 'package:unionvibe/widgets/button.dart';

class DetailedDescriptionScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final Event _event;
  const DetailedDescriptionScreen({
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
                  DetailedDescriptionEventBloc(userRepository: _userRepository)
                    ..add(LoadDetailedDescription(_event)),
              child: BlocBuilder<DetailedDescriptionEventBloc,
                  DetailedDescriptionEventState>(
                builder: (context, state) {
                  if (state is AddParticipantFailure) {
                    return columnWithTextAndIcon(
                      'Не удалось записаться',
                      Icons.error,
                    );
                  }
                  if (state is AddParticipantLoading) {
                    return Center(
                      child: Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Процесс записи',
                              style: TextStyle(
                                color: kMainColor,
                              ),
                            ),
                            CircularProgressIndicator(
                              color: kMainColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is AddParticipantSuccess) {
                    return columnWithTextAndIcon(
                      'Вы успешно записались на тренировку',
                      Icons.done,
                    );
                  }
                  if (state is AddParticipantRecordedBefore) {
                    return columnWithTextAndIcon(
                      'Вы уже записаны на тренировку',
                      Icons.error,
                    );
                  }
                  if (state is AddParticipantNoFreePlaces) {
                    return columnWithTextAndIcon(
                      'Нет свободных мест',
                      Icons.error,
                    );
                  }
                  if (state is DetailedDescriptionFailure) {
                    return columnWithTextAndIcon(
                      'Не удалось загрузить данные',
                      Icons.error,
                    );
                  }
                  if (state is DetailedDescriptionLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kMainColor,
                      ),
                    );
                  }
                  if (state is DetailedDescriptionSuccess) {
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    '${_event.date} ${_event.time}',
                                    style: TextStyle(
                                        color: kMainColor, fontSize: 16.0),
                                  ),
                                ),
                                Button(
                                    width: 200,
                                    height: 45,
                                    onPressed: () {
                                      BlocProvider.of<
                                                  DetailedDescriptionEventBloc>(
                                              context)
                                          .add(AddParticipant(_event));
                                    },
                                    text: 'Записаться'),
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
