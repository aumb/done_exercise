import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:done_exercise/core/models/booking.dart';
import 'package:done_exercise/core/repositories/booking_repository.dart';
import 'package:equatable/equatable.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc({
    required this.repository,
  }) : super(const BookingState()) {
    _budget = budgets[0];
  }

  final BookingRepository repository;

  int _stepIndex = 0;
  int get stepIndex => _stepIndex;

  String _fullName = '';
  String get fullName => _fullName;

  String _budget = '';
  String get budget => _budget;

  final List<String> budgets = [
    '1 800 - 5 000 kr',
    '5 000 - 10 000 kr',
    '10 000 - 20 000 kr',
    '20 000 - 40 000 kr',
    'Över 40 000 kr'
  ];

  @override
  Stream<BookingState> mapEventToState(
    BookingEvent event,
  ) async* {
    if (event is BookingNextStepEvent) {
      _stepIndex++;
      yield state.copyWith(
        booking: Booking(fullName: _fullName, budget: _budget),
        bookingStep: state.bookingSteps[_stepIndex],
      );
    } else if (event is BookingPreviousStepEvent) {
      _stepIndex--;
      yield state.copyWith(
        bookingStep: state.bookingSteps[_stepIndex],
      );
    } else if (event is BookingNameFormEvent) {
      _fullName = event.name;
    } else if (event is BookingBudgetFormEvent) {
      _budget = event.budget;
    } else if (event is BookingSubmitEvent) {
      yield state.copyWith(
        status: BookingStatus.loading,
      );

      await repository.postBooking();

      yield state.copyWith(
        status: BookingStatus.success,
      );
    }
  }
}
