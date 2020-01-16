import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doggy_poop_diary/datastructures/serializers.dart';
import 'package:doggy_poop_diary/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'datastructures/haufen.dart';

class MyCalendar extends StatefulWidget {
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  CalendarController _calendarController;
  Map<DateTime, List> _events;
  List _selectedEvents;

  @override
  void initState() async {
    super.initState();
    _calendarController = CalendarController();
    //_calendarController.setFocusedDay(DateTime.now());
    _calendarController.setSelectedDay(DateTime.now());
    final _selectedDay = DateTime.now();
    var _firestoreEvents = await Firestore.instance.collection(collection).getDocuments().then(_events[]);
    _events = {
      _selectedDay.subtract(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8'
      ],
    };
    for (int i = 0; i < 60; i++) {
      _events[_selectedDay.add(Duration(days: i))] = [
        'Event A8',
        'Event B8',
        'Event C8'
      ];
    }

    _selectedEvents = _events[_selectedDay] ?? [];
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedEvents = events;
    });
    print(_selectedEvents);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      _buildCalendar(),
      const SizedBox(height: 8.0),
      Expanded(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection(collection)
                .where('date',
                    isEqualTo:
                        _calendarController.focusedDay.millisecondsSinceEpoch)
                .snapshots(),
            //stream: Firestore.instance.collection(collection).snapshots(),
            builder: (context, snapshot) {
              print(_calendarController.selectedDay.millisecondsSinceEpoch);
              if (!snapshot.hasData) return const Text('Loading ... ');
              return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, snapshot.data.documents[index]));
              //print(_calendarController.focusedDay.millisecondsSinceEpoch);
//              return _buildEventList();
            }),
      ),
    ]);
  }

  Widget _buildCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
      },
      holidays: holidays,
      events: _events,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.blueAccent[400],
        todayColor: Colors.grey[400],
        holidayStyle: TextStyle().copyWith(color: Colors.pinkAccent[800]),
        outsideDaysVisible: false,
      ),
      onDaySelected: (date, events) {
        print(events);
        _onDaySelected(date, events);
      },
    );
  }

  _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 8.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
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
      onTap: () => print(_calendarController.selectedDay.millisecondsSinceEpoch),
    );
  }
}
