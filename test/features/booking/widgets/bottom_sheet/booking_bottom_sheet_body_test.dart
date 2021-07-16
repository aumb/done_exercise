import 'package:bloc_test/bloc_test.dart';
import 'package:done_exercise/core/blocs/booking/booking_bloc.dart';
import 'package:done_exercise/core/models/booking.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/booking_bottom_sheet_body.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/forms/booking_budget_form_body.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/forms/booking_name_form_body.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/forms/booking_summary_form_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../helpers/helpers.dart';

class MockBookingBloc extends MockBloc<BookingEvent, BookingState>
    implements BookingBloc {}

class BookingStateFake extends Fake implements BookingState {}

class BookingEventFake extends Fake implements BookingEvent {}

void main() {
  late BookingBloc mockBookingBloc;

  setUp(() {
    registerFallbackValue(BookingStateFake());
    registerFallbackValue(BookingEventFake());
    mockBookingBloc = MockBookingBloc();
  });

  tearDown(() {
    mockBookingBloc.close();
  });

  Future<void> setupApp(WidgetTester tester) async {
    await tester.pumpApp(
      Scaffold(body: BookingBottomSheetBody(bloc: mockBookingBloc)),
    );
  }

  void setupStepOne() {
    when(() => mockBookingBloc.state).thenReturn(const BookingState());
    when(() => mockBookingBloc.stepIndex).thenReturn(0);
  }

  void setupStepTwo() {
    when(() => mockBookingBloc.state).thenReturn(BookingState(
      bookingStep: BookingStep.budget,
      booking: Booking.empty.copyWith(fullName: 'test'),
    ));
    when(() => mockBookingBloc.stepIndex).thenReturn(1);
    when(() => mockBookingBloc.budgets).thenReturn(
      [
        '1 800 - 5 000 kr',
        '5 000 - 10 000 kr',
        '10 000 - 20 000 kr',
        '20 000 - 40 000 kr',
        'Över 40 000 kr'
      ],
    );
    when(() => mockBookingBloc.budget).thenReturn(
      mockBookingBloc.budgets[0],
    );
  }

  void setupStepThree() {
    when(() => mockBookingBloc.state).thenReturn(BookingState(
      bookingStep: BookingStep.summary,
      booking: Booking.empty.copyWith(fullName: 'test', budget: 'test1'),
    ));
    when(() => mockBookingBloc.stepIndex).thenReturn(2);
  }

  group('BookingBottomSheetBody', () {
    testWidgets(
      'renders BookingNameFormBody when booking step is BookingStep.name',
      (WidgetTester tester) async {
        setupStepOne();
        await setupApp(tester);
        await tester.pumpAndSettle();
        expect(find.byType(BookingNameFormBody), findsOneWidget);
      },
    );

    testWidgets(
      'renders BookingBudgetFormBody when booking step is BookingStep.budget',
      (WidgetTester tester) async {
        setupStepTwo();
        await setupApp(tester);
        await tester.pumpAndSettle();
        expect(find.byType(BookingBudgetFormBody), findsOneWidget);
      },
    );

    testWidgets(
      '''renders BookingBudgetSummaryBody when booking step is BookingStep.budget''',
      (WidgetTester tester) async {
        setupStepThree();
        await setupApp(tester);
        await tester.pumpAndSettle();
        expect(find.byType(BookingSummaryFormBody), findsOneWidget);
      },
    );
  });
}
