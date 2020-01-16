import 'package:doggy_poop_diary/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyEventList extends StatefulWidget {
  DateTime selectedDay;

  @override
  _MyEventListState createState() => _MyEventListState(this.selectedDay);

  MyEventList(this.selectedDay);
}

class _MyEventListState extends State<MyEventList> {
  DateTime _selectedDay;

  _MyEventListState(this._selectedDay);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getSelectedEvents(),
        //stream: Firestore.instance.collection(collection).snapshots(),
        builder: (context, snapshot) {
          //print(_calendarController.selectedDay.millisecondsSinceEpoch);
          if (!snapshot.hasData) return const Text('Loading ... ');
          return ListView.builder(
              itemExtent: 80.0,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]));
          //print(_calendarController.focusedDay.millisecondsSinceEpoch);
          //              return _buildEventList();
        });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 8.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(document['segment']),
      ),
      onTap: () => print(_selectedDay.millisecondsSinceEpoch),
    );
  }

  Future<QuerySnapshot> _getSelectedEvents() async {
    print(_selectedDay);
    return await Firestore.instance
        .collection(collection)
        .where('date', isEqualTo: _selectedDay.millisecondsSinceEpoch)
        .getDocuments();
  }
}
