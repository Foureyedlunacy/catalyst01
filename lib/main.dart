
import 'package:catalyst/dashboard.dart';
import 'package:catalyst/github.dart';
import 'package:catalyst/home.dart';

import 'package:catalyst/homecomponents/components/projectdashboard.dart';
import 'package:catalyst/homecomponents/project.dart';
import 'package:flutter/material.dart';




void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/GitHub': (context) => const Github(),
        '/Project': (context) => const Projectpage(),
        '/Dashboard': (context) => const Dashboard(),

        

      },
    ),
  );
}