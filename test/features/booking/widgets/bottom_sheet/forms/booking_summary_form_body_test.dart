import 'package:bloc_test/bloc_test.dart';
import 'package:done_exercise/components/custom_activity_indicator.dart';
import 'package:done_exercise/components/custom_divider.dart';
import 'package:done_exercise/components/label_list_tile.dart';
import 'package:done_exercise/core/blocs/booking/booking_bloc.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/forms/booking_summary_form_body.dart';
import 'package:done_exercise/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../../helpers/helpers.dart';

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
    when(() => mockBookingBloc.repository.postBooking())
        .thenAnswer((_) async => true);
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
    await tester.pumpApp(
      Scaffold(
        body: BookingSummaryFormBody(
          bloc: mockBookingBloc,
        ),
      ),
    );
  }

  group('BookingSummaryFormBody', () {
    testWidgets('renders two LabelListTile', (tester) async {
      when(() => mockBookingBloc.state).thenReturn(
        const BookingState(
          bookingStep: BookingStep.summary,
        ),
      );
      await setupApp(tester);
      await tester.pumpAndSettle();
      expect(find.byType(LabelListTile), findsNWidgets(2));
    });

    testWidgets('renders 2 CustomDivider', (tester) async {
      when(() => mockBookingBloc.state).thenReturn(
        const BookingState(
          bookingStep: BookingStep.summary,
        ),
      );
      await setupApp(tester);
      await tester.pumpAndSettle();
      expect(find.byType(CustomDivider), findsNWidgets(2));
    });

    testWidgets('calls BookingSubmitEvent when continue button is clicked',
        (tester) async {
      const key = ValueKey('confirm_booking_button_key');

      when(() => mockBookingBloc.state).thenReturn(
        const BookingState(
          bookingStep: BookingStep.summary,
        ),
      );

      await setupApp(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      verify(() => mockBookingBloc.add(BookingSubmitEvent()));
    });

    testWidgets('renders progress indicator when loading', (tester) async {
      when(() => mockBookingBloc.state).thenReturn(
        const BookingState(
          bookingStep: BookingStep.summary,
          status: BookingStatus.loading,
        ),
      );

      await setupApp(tester);
      expect(find.byType(CustomActivityIndicator), findsOneWidget);
    });

    testWidgets('renders confirming text when loading', (tester) async {
      when(() => mockBookingBloc.state).thenReturn(
        const BookingState(
          bookingStep: BookingStep.summary,
          status: BookingStatus.loading,
        ),
      );

      await setupApp(tester);
      expect(find.text(Strings.confirming), findsOneWidget);
    });
  });
}
