import 'package:done_exercise/components/custom_elevated_button.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/booking_bottom_sheet_page.dart';
import 'package:done_exercise/utils/strings.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BookingView();
  }
}

class BookingView extends StatelessWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomElevatedButton(
              key: const Key('start_booking_key'),
              onPressed: () => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (_) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.94),
                    child: const BookingBottomSheetPage(),
                  );
                },
              ),
              label: Strings.startBooking,
            ),
          )
        ],
      ),
    );
  }
}
