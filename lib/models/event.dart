import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String creator;
  final String typeOfSport;
  final String date;
  final String time;
  final String location;
  final String description;
  final String levelOfSkill;
  final int countOfParticipants;
  final List<dynamic> participants;
  final String eventId;

  Event(
      {required this.creator,
      required this.typeOfSport,
      required this.date,
      required this.time,
      required this.location,
      required this.description,
      required this.levelOfSkill,
      required this.eventId,
      required this.countOfParticipants,
      required this.participants});

  static String dateFromTimestamp(Timestamp timestamp) {
    final String dateAndTime = timestamp.toDate().toString();
    final String year = dateAndTime.substring(0, 4);
    final String month = dateAndTime.substring(5, 7);
    final String day = dateAndTime.substring(8, 10);
    return '$day.$month.$year';
  }

  static String timeFromTimestamp(Timestamp timestamp) {
    final String dateAndTime = timestamp.toDate().toString();
    final String hours = dateAndTime.substring(11, 13);
    final String minutes = dateAndTime.substring(14, 16);
    return '$hours:$minutes';
  }

  static Event fromSnapshot(DocumentSnapshot snap, String id ) {
    final data = snap.data();
    if (data == null) throw Exception();
    return Event(
      creator: data['creator'],
      typeOfSport: data['typeOfSport'],
      date: dateFromTimestamp(data['dateAndTime']),
      time: timeFromTimestamp(data['dateAndTime']),
      location: data['location'],
      description: data['description'],
      levelOfSkill: data['levelOfSkill'],
      countOfParticipants: data['countOfParticipants'],
      participants: data['participants'],
      eventId: id,
    );
  }
}
