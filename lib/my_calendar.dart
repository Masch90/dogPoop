import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  Map<DateTime, List<Haufen>> _events = {};
  DateTime _selectedDay;
  List<Haufen> _selectedEvents = [];

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

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      events = events.cast<Haufen>();
      if (events.isNotEmpty) {
        _selectedEvents = events;
      } else {
        _selectedEvents = [];
      }
      _selectedEvents = events;
      _getEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      _buildCalendar(),
      const SizedBox(height: 8.0),
      Expanded(
        child: _buildEventList(),
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
      onDaySelected: (date, events) => _onDaySelected(date, events),
    );
  }

  _buildEventList() {
    if (_selectedEvents.length < 3) {
      _fillUpSelectedEvents();
    }
    _selectedEvents.sort((a, b) => a.segment.compareTo(b.segment));
    return ListView(
      children: _selectedEvents
          .map((event) => Card(
                elevation: 16.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                      title: Row(
                        children: <Widget>[
                          _getEmoticon(event.rating),
                          Flexible(child: Text(event.comment)),
                        ],
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.thumb_up),
                                    title: Text('Neuer Haufen'),
                                  )
                                ],
                              );
                            });
                        print('$event tapped!');
                      }),
                ),
              ))
          .toList(),
    );
  }

  void _getEvents() async {
    Map<DateTime, List<Haufen>> events = {};
    await Firestore.instance
        .collection(collection)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((document) {
        Haufen haufen = Haufen.fromJson(jsonEncode(document.data));
        if (events
            .containsKey(DateTime.fromMillisecondsSinceEpoch(haufen.date))) {
          events[DateTime.fromMillisecondsSinceEpoch(haufen.date)].add(haufen);
        } else {
          events[DateTime.fromMillisecondsSinceEpoch(haufen.date)] = [haufen];
        }
      });
    });
    _events = events;
  }

  Icon _getEmoticon(int rating) {
    double iconSize = 80.0;
    Color iconColor = Colors.black;
    IconData iconData = Icons.sentiment_dissatisfied;
    switch (rating) {
      case 0:
        iconData = Icons.pets;
        break;
      case 1:
        iconColor = Colors.red[900];
        iconData = Icons.sentiment_very_dissatisfied;
        break;
      case 2:
        iconColor = Colors.red[400];
        iconData = Icons.sentiment_dissatisfied;
        break;
      case 3:
        iconColor = Colors.yellow;
        iconData = Icons.sentiment_neutral;
        break;
      case 4:
        iconColor = Colors.green[400];
        iconData = Icons.sentiment_satisfied;
        break;
      case 5:
        iconColor = Colors.green[900];
        iconData = Icons.sentiment_very_satisfied;
        break;
    }
    return Icon(
      iconData,
      color: iconColor,
      size: iconSize,
    );
  }

  void _fillUpSelectedEvents() {
    List<Haufen> displayList = [];
    _selectedEvents.forEach((element) => displayList.add(element));
    for (var i = 1; i < 4; i++) {
      if (!displayList.any((element) {
        return element.segment == i;
      })) {
        HaufenBuilder haufenBuilder = HaufenBuilder();
        haufenBuilder.comment = 'klick hier um einen neuen Haufen anzulegen';
        haufenBuilder.rating = 0;
        haufenBuilder.segment = i;
        haufenBuilder.date = 0;
        displayList.add(haufenBuilder.build());
      }
    }
    setState(() {
      _selectedEvents = displayList;
    });
  }
}
