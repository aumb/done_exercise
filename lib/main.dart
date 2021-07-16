import 'dart:async';
import 'dart:developer';

import 'package:done_exercise/app_bloc_observer.dart';
import 'package:done_exercise/utils/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:done_exercise/features/booking/booking_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  runZonedGuarded(
    () => runApp(const MyApp()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Done Exercise',
      themeMode: ThemeMode.light,
      theme: CustomTheme.light,
      home: const BookingPage(),
    );
  }
}
