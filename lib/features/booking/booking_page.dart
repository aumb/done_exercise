import 'package:done_exercise/components/custom_elevated_button.dart';
import 'package:done_exercise/utils/strings.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BookingView();
  }
}

class BookingView extends StatelessWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomElevatedButton(
            onPressed: () {},
            label: Strings.startBooking,
          )
        ],
      ),
    );
  }
}
