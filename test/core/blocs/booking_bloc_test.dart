import 'package:bloc_test/bloc_test.dart';
import 'package:done_exercise/core/blocs/booking/booking_bloc.dart';
import 'package:done_exercise/core/models/booking.dart';
import 'package:done_exercise/core/repositories/booking_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  late MockBookingRepository mockBookingRepository;

  const nameState = BookingState(
    booking: Booking.empty,
    status: BookingStatus.initial,
    bookingStep: BookingStep.name,
  );

  final nameStatePrev = BookingState(
    booking: Booking.empty
        .copyWith(fullName: 'John Doe', budget: '1 800 - 5 000 kr'),
    status: BookingStatus.initial,
    bookingStep: BookingStep.name,
  );

  final budgetState = BookingState(
    booking: Booking.empty
        .copyWith(fullName: 'John Doe', budget: '1 800 - 5 000 kr'),
    status: BookingStatus.initial,
    bookingStep: BookingStep.budget,
  );

  final summaryState = BookingState(
    booking: Booking.empty
        .copyWith(fullName: 'John Doe', budget: '1 800 - 5 000 kr'),
    status: BookingStatus.initial,
    bookingStep: BookingStep.summary,
  );

  setUp(() {
    mockBookingRepository = MockBookingRepository();
  });

  group('BookingBloc', () {
    group('Next Steps', () {
      blocTest<BookingBloc, BookingState>(
        'emits intial state',
        build: () => BookingBloc(repository: mockBookingRepository),
        verify: (bloc) {
          expect(nameState, equals(bloc.state));
          expect(bloc.stepIndex, equals(0));
          expect(bloc.state.status.isInitial, equals(true));
          expect(bloc.state.status.isFailure, equals(false));
          expect(bloc.state.status.isLoading, equals(false));
          expect(bloc.state.status.isSuccess, equals(false));
        },
      );

      blocTest<BookingBloc, BookingState>(
        'emits step two',
        build: () => BookingBloc(repository: mockBookingRepository),
        act: (bloc) {
          bloc
            ..add(
              const BookingNameFormEvent(name: 'John Doe'),
            )
            ..add(
              BookingNextStepEvent(),
            );
        },
        verify: (bloc) {
          expect(budgetState, equals(bloc.state));
          expect(bloc.stepIndex, equals(1));
        },
      );

      blocTest<BookingBloc, BookingState>(
        'emits step three',
        build: () => BookingBloc(repository: mockBookingRepository),
        act: (bloc) {
          bloc
            ..add(
              const BookingNameFormEvent(name: 'John Doe'),
            )
            ..add(
              BookingNextStepEvent(),
            )
            ..add(
              BookingBudgetFormEvent(budget: bloc.budgets[0]),
            )
            ..add(
              BookingNextStepEvent(),
            );
        },
        verify: (bloc) {
          expect(summaryState, equals(bloc.state));
          expect(bloc.stepIndex, equals(2));
        },
      );
    });

    group('Previous Steps', () {
      blocTest<BookingBloc, BookingState>(
        'emits step two',
        build: () => BookingBloc(repository: mockBookingRepository),
        act: (bloc) {
          bloc
            ..add(
              const BookingNameFormEvent(name: 'John Doe'),
            )
            ..add(
              BookingNextStepEvent(),
            )
            ..add(
              BookingBudgetFormEvent(budget: bloc.budgets[0]),
            )
            ..add(
              BookingNextStepEvent(),
            )
            ..add(
              BookingPreviousStepEvent(),
            );
        },
        verify: (bloc) {
          expect(budgetState, equals(bloc.state));
          expect(bloc.stepIndex, equals(1));
        },
      );

      blocTest<BookingBloc, BookingState>(
        'emits intial state',
        build: () => BookingBloc(repository: mockBookingRepository),
        act: (bloc) {
          bloc
            ..add(
              const BookingNameFormEvent(name: 'John Doe'),
            )
            ..add(
              BookingNextStepEvent(),
            )
            ..add(
              BookingPreviousStepEvent(),
            );
        },
        verify: (bloc) {
          expect(nameStatePrev, equals(bloc.state));
          expect(bloc.stepIndex, equals(0));
        },
      );
    });

    group('Change variables', () {
      blocTest<BookingBloc, BookingState>(
        'changes full name to provided value',
        build: () => BookingBloc(repository: mockBookingRepository),
        act: (bloc) => bloc.add(
          const BookingNameFormEvent(name: 'John Doe'),
        ),
        verify: (bloc) {
          expect(bloc.fullName, equals('John Doe'));
        },
      );

      blocTest<BookingBloc, BookingState>(
        'changes budget to provided value',
        build: () => BookingBloc(repository: mockBookingRepository),
        act: (bloc) => bloc.add(
          BookingBudgetFormEvent(budget: bloc.budgets[0]),
        ),
        verify: (bloc) {
          expect(bloc.budget, equals(bloc.budgets[0]));
        },
      );
    });

    group('Change status', () {
      blocTest<BookingBloc, BookingState>(
        'emits BookingStatus.Loading, BookingStatus.Loaded',
        build: () {
          when(() => mockBookingRepository.postBooking()).thenAnswer(
            (_) async => true,
          );
          return BookingBloc(repository: mockBookingRepository);
        },
        act: (bloc) => bloc.add(BookingSubmitEvent()),
        verify: (_) {
          verify(() => mockBookingRepository.postBooking()).called(1);
        },
        expect: () => [
          const BookingState(status: BookingStatus.loading),
          const BookingState(status: BookingStatus.success),
        ],
      );
    });
  });
}
