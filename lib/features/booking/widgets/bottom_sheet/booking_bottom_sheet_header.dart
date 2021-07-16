import 'package:done_exercise/core/blocs/booking/booking_bloc.dart';
import 'package:done_exercise/utils/strings.dart';
import 'package:flutter/material.dart';

class BookingBottomSheetHeader extends StatelessWidget {
  const BookingBottomSheetHeader({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final BookingBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 28.0, bottom: 21.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (bloc.stepIndex != 0) const SizedBox(width: 20),
              if (bloc.stepIndex != 0)
                InkWell(
                  key: const Key('booking_back_button_key'),
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => bloc.add(
                    BookingPreviousStepEvent(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
              SizedBox(width: bloc.stepIndex != 0 ? 16 : 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _getTitleForStatus(),
                      key: const Key('title_text_key'),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      Strings.bookForQuote,
                      key: const Key('book_quote_text_key'),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      Strings.cancel,
                      key: const Key('cancel_booking_button_key'),
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  String _getTitleForStatus() {
    switch (bloc.state.bookingStep) {
      case BookingStep.name:
        return Strings.name;
      case BookingStep.budget:
        return Strings.budget;
      case BookingStep.summary:
        return Strings.summary;
    }
  }
}
