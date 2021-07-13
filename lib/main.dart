import 'package:flutter/material.dart';

import 'package:done_exercise/features/booking/booking_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Done Exercise',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        accentColor: Color(0xFF6734C7),
        primarySwatch: Colors.blue,
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        buttonTheme: ButtonThemeData(buttonColor: Colors.black),
        //TODO: figure out theme on figma
        textTheme: TextTheme(),
        inputDecorationTheme: InputDecorationTheme(
          //TODO: correct it when theme is figured
          labelStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Color(0xFFC4C4C4),
            ),
          ),
        ),
      ),
      home: BookingPage(),
    );
  }
}
