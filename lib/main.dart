import 'package:flutter/material.dart';
import 'package:github_jobs_app/Screens/JobsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF495464),
        backgroundColor: Color(0xFFF4F4F2),
        accentColor: Color(0xFFBBBFCA),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Color(0xFF495464),
              displayColor: Color(0xFF495464),
            ),
      ),
      home: JobsScreen(),
    );
  }
}
