import 'package:doggy_poop_diary/util/data_management.dart';
import 'package:flutter/material.dart';

import '../my_calendar.dart';
import 'package:doggy_poop_diary/util/constants.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getEvents();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
        ),
        centerTitle: true,
      ),
      body: MyCalendar(),
    );
  }
}
