import 'package:done_exercise/components/custom_divider.dart';
import 'package:done_exercise/components/custom_elevated_button.dart';
import 'package:done_exercise/components/label_list_tile.dart';
import 'package:done_exercise/core/blocs/booking/booking_bloc.dart';
import 'package:done_exercise/utils/strings.dart';
import 'package:flutter/material.dart';

class BookingSummaryFormBody extends StatelessWidget {
  const BookingSummaryFormBody({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final BookingBloc bloc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 21),
        child: Column(
          children: [
            const SizedBox(height: 26),
            LabelListTile(
                label: Strings.namn, value: bloc.state.booking.fullName),
            const CustomDivider(),
            LabelListTile(
                label: Strings.budget, value: bloc.state.booking.budget),
            const CustomDivider(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            Padding(
              padding: const EdgeInsets.only(right: 21.0, bottom: 22.0),
              child: CustomElevatedButton(
                key: const ValueKey('confirm_booking_button_key'),
                label: bloc.state.status.isLoading
                    ? Strings.confirming
                    : Strings.confirmBooking,
                isLoading: bloc.state.status.isLoading,
                onPressed: () => bloc.add(BookingSubmitEvent()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
