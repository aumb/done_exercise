import 'package:done_exercise/components/animated_progress_bar.dart';
import 'package:done_exercise/core/blocs/booking/booking_bloc.dart';
import 'package:done_exercise/core/repositories/booking_repository.dart';
import 'package:done_exercise/features/booking/widgets/booking_complete_dialog.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/booking_bottom_sheet_body.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/booking_bottom_sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingBottomSheetPage extends StatelessWidget {
  const BookingBottomSheetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc(
        repository: BookingRepository(),
      ),
      child: BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (_) => const BookingCompleteDialog(),
            );
          }
        },
        child: const BookingBottomSheetView(),
      ),
    );
  }
}

class BookingBottomSheetView extends StatelessWidget {
  const BookingBottomSheetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((BookingBloc c) => c.state);
    final bloc = context.read<BookingBloc>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingBottomSheetHeader(
                bloc: bloc,
              ),
              AnimatedProgressBar(
                fraction: (bloc.stepIndex + 1) / state.bookingSteps.length,
              ),
              BookingBottomSheetBody(
                bloc: bloc,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
