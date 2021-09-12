import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unionvibe/models/event.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepository()
      : _firebaseAuth = FirebaseAuth.instance,
        _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithCredentials(
      String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  bool isSignedIn() {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  getUser() {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser;
  }

  Future<void> addUser(String surname, String name) async {
    _firestore.collection('users').doc(getUser().uid).set({
      'surname': surname,
      'name': name,
    }).then((value) {
      print("User Added");
    });
  }

  Future<void> addEvent(
      String typeOfSport,
      final String dateAndTime,
      final String location,
      final String description,
      final String levelOfSkill,
      final String countOfParticipants) async {
    final List<String> participants = [
      getUser().uid,
    ];
    _firestore.collection('events').add({
      'creator': getUser().uid,
      'typeOfSport': typeOfSport,
      'dateAndTime': Timestamp.fromDate(DateTime.parse(dateAndTime)),
      'location': location,
      'description': description,
      'levelOfSkill': levelOfSkill,
      'countOfParticipants': int.parse(countOfParticipants),
      'creationTime': Timestamp.fromDate(DateTime.now()),
      'participants': participants,
    }).then((value) {
      print("Event Added");
    });
  }

  Future<DocumentSnapshot> getUserData(String uid) async {
    return await _firestore.collection('users').doc(uid).get();
  }

  Stream<List<Event>> events() {
    return _firestore
        .collection('events')
        .orderBy('dateAndTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Event.fromSnapshot(doc, doc.id))
          .toList();
    });
  }

  Future<void> addParticipant(String idEvent) async {
    await _firestore.collection('events').doc(idEvent).update({
      'participants': FieldValue.arrayUnion([getUser().uid])
    }).then((value) => print('Add participant in event $idEvent'));
  }

  Stream<List<Event>> myBookedEvents() {
    return _firestore
        .collection('events')
        .where('participants', arrayContainsAny: [getUser().uid])
        .orderBy('dateAndTime', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Event.fromSnapshot(doc, doc.id))
              .toList();
        });
  }
}
