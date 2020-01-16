import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String key;
  int rating;
  String comment;
  DateTime date;
  DaySegment segment;

  Event.fromSnapshot(DocumentSnapshot snapshot)
    : key = snapshot.documentID,
    rating = snapshot['rating'],
    comment = snapshot['comment'],
    date = snapshot['date'],
    segment = snapshot['segment'];
}

enum DaySegment {
  morning,
  midday,
  evening,
}
