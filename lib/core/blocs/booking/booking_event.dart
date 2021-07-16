part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class BookingNextStepEvent extends BookingEvent {}

class BookingPreviousStepEvent extends BookingEvent {}

class BookingSubmitEvent extends BookingEvent {}

class BookingNameFormEvent extends BookingEvent {
  const BookingNameFormEvent({
    required this.name,
  });

  final String name;
}

class BookingBudgetFormEvent extends BookingEvent {
  const BookingBudgetFormEvent({
    required this.budget,
  });

  final String budget;
}
