import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doggy_poop_diary/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'myEventList.dart';

class MyCalendar extends StatefulWidget {
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  CalendarController _calendarController;
  Map<DateTime, List> _events = {};
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day) {
    setState(() {
      _selectedDay = day;
      _calendarController.setSelectedDay(day);
    });
    print('selected day:' + day.toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      FutureBuilder<QuerySnapshot>(
        future: _getEvents(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            snapshot.data.documents.forEach((e) {
              _events[DateTime.fromMillisecondsSinceEpoch(e['date'])] = [
                e['rating'],
                e['segment'],
                e['comment']
              ];
            });
            return _buildCalendar();
          } else {
            return Text('Not done!');
          }
        },
      ),
      const SizedBox(height: 8.0),
      Expanded(
        child: MyEventList(_calendarController.selectedDay),
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
      onDaySelected: (date, events) => _onDaySelected(date),
    );
  }

/*   _buildEventList() {
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
  } */

/*           test() async {
            StreamBuilder.
            var test = await Firestore.instance
                .collection(collection)
                .getDocuments()
                .then((qS) => qS.documentChanges);
            print(test);
            FutureBuilder<Map<DateTime, List<dynamic>>>
            Map<DateTime, List<dynamic>> maptest = {};
            test.forEach((dataset) {
              maptest[DateTime.fromMillisecondsSinceEpoch(dataset.document.data['date'])] = [dataset.document.data['segment']];
            });
            print(maptest);
            _events = maptest;
            Future.wait(test);
          } */

  Future<QuerySnapshot> _getEvents() async {
    return await Firestore.instance.collection(collection).getDocuments();
  }
}
