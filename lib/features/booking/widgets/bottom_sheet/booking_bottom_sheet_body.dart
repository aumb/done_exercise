import 'package:done_exercise/components/animated_form.dart';
import 'package:done_exercise/core/blocs/booking/booking_bloc.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/forms/booking_budget_form_body.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/forms/booking_name_form_body.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/forms/booking_summary_form_body.dart';
import 'package:flutter/material.dart';

class BookingBottomSheetBody extends StatelessWidget {
  const BookingBottomSheetBody({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final BookingBloc bloc;

  @override
  Widget build(BuildContext context) {
    switch (bloc.state.bookingStep) {
      case BookingStep.name:
        return AnimatedForm(child: BookingNameFormBody(bloc: bloc));
      case BookingStep.budget:
        return AnimatedForm(child: BookingBudgetFormBody(bloc: bloc));
      case BookingStep.summary:
        return AnimatedForm(
          shouldReset: bloc.state.status != BookingStatus.loading,
          child: BookingSummaryFormBody(bloc: bloc),
        );
    }
  }
}
