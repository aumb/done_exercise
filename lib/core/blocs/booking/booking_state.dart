part of 'booking_bloc.dart';

enum BookingStatus { initial, loading, success, failure }
enum BookingStep { name, budget, summary }

extension BookingStatusX on BookingStatus {
  bool get isInitial => this == BookingStatus.initial;
  bool get isLoading => this == BookingStatus.loading;
  bool get isSuccess => this == BookingStatus.success;
  bool get isFailure => this == BookingStatus.failure;
}

class BookingState extends Equatable {
  const BookingState({
    this.status = BookingStatus.initial,
    this.bookingStep = BookingStep.name,
    Booking? booking,
  }) : booking = booking ?? Booking.empty;

  final BookingStatus status;
  final Booking booking;
  final BookingStep bookingStep;

//How the steps are ordered
  final List<BookingStep> bookingSteps = const [
    BookingStep.name,
    BookingStep.budget,
    BookingStep.summary
  ];

  BookingState copyWith({
    BookingStatus? status,
    Booking? booking,
    BookingStep? bookingStep,
  }) {
    return BookingState(
      status: status ?? this.status,
      booking: booking ?? this.booking,
      bookingStep: bookingStep ?? this.bookingStep,
    );
  }

  @override
  List<Object?> get props => [
        status,
        booking,
        bookingStep,
        bookingSteps,
      ];
}
