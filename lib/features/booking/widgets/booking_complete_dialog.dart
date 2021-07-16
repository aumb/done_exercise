import 'package:done_exercise/components/custom_dialog.dart';
import 'package:done_exercise/components/custom_elevated_button.dart';
import 'package:done_exercise/utils/strings.dart';
import 'package:flutter/material.dart';

class BookingCompleteDialog extends StatelessWidget {
  const BookingCompleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      children: [
        Text(
          Strings.bookingComplete,
          key: const Key('booking_complete_text_key'),
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 40),
        CustomElevatedButton(
            key: const Key('booking_complete_button_key'),
            onPressed: () => Navigator.of(context).pop(),
            label: Strings.dimiss),
      ],
    );
  }
}
