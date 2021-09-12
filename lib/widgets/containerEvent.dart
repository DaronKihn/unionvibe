import 'package:flutter/material.dart';
import 'package:unionvibe/models/event.dart';
import 'package:unionvibe/widgets/button.dart';

import '../constants.dart';

class ContainerEvent extends StatelessWidget {
  final Event _event;
  final _onPressed;
  final String _titleButton;
  const ContainerEvent(
      {Key? key,
      required Event event,
      required Function onPressed,
      required String titleButton})
      : _event = event,
        _titleButton = titleButton,
        _onPressed = onPressed,
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: kMainColor,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            iconWithText(Icons.directions_bike, _event.typeOfSport),
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
                    style: TextStyle(color: kMainColor, fontSize: 17.0),
                    overflow: TextOverflow.ellipsis,
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
                    style: TextStyle(color: kMainColor, fontSize: 17.0),
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
                  child: Text('${_event.date} ${_event.time}'),
                ),
                Button(
                    width: 200,
                    height: 45,
                    onPressed: _onPressed,
                    text: _titleButton),
              ],
            )
          ],
        ),
      ),
    );
  }
}
