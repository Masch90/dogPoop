import 'package:flutter/material.dart';

import 'package:doggy_poop_diary/pages/Home.dart';

void main() => runApp(MaterialApp(
      routes: {
        '/': (context) => Home(),
      },
    ));
