import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unionvibe/blocs/create_event_bloc/create_event_bloc.dart';
import 'package:unionvibe/repositoryies/user_repository.dart';
import 'package:unionvibe/widgets/button.dart';

import '../constants.dart';

class CreateEventScreen extends StatefulWidget {
  final UserRepository _userRepository;
  const CreateEventScreen({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  String? _typeOfSport = 'Вид спорта';
  String? _levelOfSkill = 'Уровень участников';
  final _dateAndTimeController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _countOfParticipantsController = TextEditingController();

  final typesOfSport = [
    'Вид спорта',
    'Бег',
    'Волейбол',
    'Баскетбол',
    'Стритбол',
    'Настольный теннис',
    'Футбол',
  ];
  final levelsOfSkill = [
    'Уровень участников',
    'Начинающий',
    'Средний',
    'Продвинутый',
  ];

  bool get isPopulated =>
      _locationController.text.isNotEmpty &&
      _dateAndTimeController.text.isNotEmpty &&
      _descriptionController.text.isNotEmpty &&
      _countOfParticipantsController.text.isNotEmpty &&
      (_typeOfSport != 'Вид спорта') &&
      (_levelOfSkill != 'Уровень участников');

  @override
  void dispose() {
    super.dispose();
    _dateAndTimeController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _countOfParticipantsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Организация занятия'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) =>
            CreateEventBloc(userRepository: widget._userRepository),
        child: BlocListener<CreateEventBloc, CreateEventState>(
          listener: (context, state) {
            if (state is CreateEventFailure) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Не удалось организовать'),
                      Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is CreateEventLoading) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Загрузка'),
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ],
                ),
              ));
            }
            if (state is CreateEventSuccess) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Успешно!'),
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ],
                ),
              ));
            }
          },
          child: BlocBuilder<CreateEventBloc, CreateEventState>(
            builder: (context, state) {
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: kLinearGradientReversed,
                    ),
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          DropdownButtonFormField<String>(
                            value: _typeOfSport,
                            items: typesOfSport.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (val) =>
                                setState(() => _typeOfSport = val),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (_) {
                              return _typeOfSport == 'Вид спорта'
                                  ? 'Пустое поле'
                                  : null;
                            },
                            style: TextStyle(color: kMainColor, fontSize: 16.0),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.directions_bike,
                                color: kMainColor,
                              ),
                              focusColor: kMainColor,
                            ),
                          ),
                          DateTimePicker(
                            controller: _dateAndTimeController,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: 'Дата и время тренировки',
                              labelStyle: TextStyle(
                                color: kMainColor,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: kMainColor,
                              )),
                              icon: Icon(
                                Icons.today,
                                color: kMainColor,
                              ),
                            ),
                            type: DateTimePickerType.dateTime,
                            dateMask: 'd.MM.yyyy hh:mm',
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            icon: Icon(Icons.event),
                            dateLabelText: 'Дата',
                            timeLabelText: "Время",
                            validator: (_) {
                              return _dateAndTimeController.text.isEmpty
                                  ? 'Пустое поле'
                                  : null;
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          TextFormField(
                            controller: _locationController,
                            style: TextStyle(fontSize: 16.0),
                            decoration: InputDecoration(
                              labelText: 'Адрес',
                              labelStyle: TextStyle(
                                color: kMainColor,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: kMainColor,
                              )),
                              icon: Icon(
                                Icons.location_on,
                                color: kMainColor,
                              ),
                            ),
                            cursorColor: kMainColor,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            autocorrect: false,
                            validator: (_) {
                              return _locationController.text.isEmpty
                                  ? 'Пустое поле'
                                  : null;
                            },
                          ),
                          TextFormField(
                            controller: _descriptionController,
                            style: TextStyle(fontSize: 16.0),
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Описание',
                              labelStyle: TextStyle(
                                color: kMainColor,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: kMainColor,
                              )),
                              icon: Icon(
                                Icons.create,
                                color: kMainColor,
                              ),
                            ),
                            cursorColor: kMainColor,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            autocorrect: false,
                            validator: (_) {
                              return _descriptionController.text.isEmpty
                                  ? 'Пустое поле'
                                  : null;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          DropdownButtonFormField<String>(
                            value: _levelOfSkill,
                            items: levelsOfSkill.map((level) {
                              return DropdownMenuItem(
                                value: level,
                                child: Text(level),
                              );
                            }).toList(),
                            onChanged: (val) =>
                                setState(() => _levelOfSkill = val),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (_) {
                              return _levelOfSkill == 'Уровень участников'
                                  ? 'Пустое поле'
                                  : null;
                            },
                            style: TextStyle(color: kMainColor, fontSize: 16.0),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.trending_up,
                                color: kMainColor,
                              ),
                              focusColor: kMainColor,
                            ),
                          ),
                          TextFormField(
                            controller: _countOfParticipantsController,
                            style: TextStyle(fontSize: 16.0),
                            decoration: InputDecoration(
                              labelText: 'Количество участников',
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.done,
                            autocorrect: false,
                            validator: (_) {
                              return _countOfParticipantsController.text.isEmpty
                                  ? 'Пустое поле'
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
                                // print(_typeOfSport);
                                // print(_dateAndTimeController.text);
                                // print(_locationController.text);
                                // print(_descriptionController.text);
                                // print(_levelOfSkill);
                                // print(_countOfParticipantsController);
                                if (isPopulated) {
                                  BlocProvider.of<CreateEventBloc>(context).add(
                                      CreateEventSubmitted(
                                          typeOfSport: _typeOfSport,
                                          dateAndTime:
                                              _dateAndTimeController.text,
                                          location: _locationController.text,
                                          description:
                                              _descriptionController.text,
                                          levelOfSkill: _levelOfSkill,
                                          countOfParticipants:
                                              _countOfParticipantsController
                                                  .text));
                                  setState(() {
                                    _typeOfSport = 'Вид спорта';
                                    _levelOfSkill = 'Уровень участников';
                                  });
                                  _dateAndTimeController.clear();
                                  _descriptionController.clear();
                                  _locationController.clear();
                                  _countOfParticipantsController.clear();
                                  print('yes');
                                } else {
                                  print('no');
                                }
                              },
                              text: 'Организовать'),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
