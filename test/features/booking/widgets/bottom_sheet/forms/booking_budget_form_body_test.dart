import 'package:bloc_test/bloc_test.dart';
import 'package:done_exercise/components/custom_outline_button.dart';
import 'package:done_exercise/core/blocs/booking/booking_bloc.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/forms/booking_budget_form_body.dart';
import 'package:done_exercise/utils/custom_theme.dart';
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
    when(() => mockBookingBloc.state).thenReturn(
      const BookingState(
        bookingStep: BookingStep.budget,
      ),
    );
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
        body: BookingBudgetFormBody(
          bloc: mockBookingBloc,
        ),
      ),
    );
  }

  group('BookingBudgetFormBody', () {
    testWidgets('renders budget intro text', (tester) async {
      const key = ValueKey('budget_intro_text_key');
      await setupApp(tester);
      await tester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets('renders budget list length number of buttons', (tester) async {
      await setupApp(tester);
      await tester.pumpAndSettle();
      expect(find.byType(CustomOutlinedButton),
          findsNWidgets(mockBookingBloc.budgets.length));
    });

    testWidgets('renders accent color border on selected budget',
        (tester) async {
      const key = ValueKey('5 000 - 10 000 kr');
      final findButton = find.byKey(key);
      CustomOutlinedButton? button;

      await setupApp(tester);
      await tester.pumpAndSettle();
      button = tester.firstWidget(findButton) as CustomOutlinedButton?;
      expect(button?.borderColor, equals(null));
      when(() => mockBookingBloc.budget).thenReturn(
        mockBookingBloc.budgets[1],
      );

      await tester.tap(findButton);
      await tester.pumpAndSettle();
      button = tester.firstWidget(findButton) as CustomOutlinedButton;
      expect(button.borderColor, equals(CustomColors.accentColor));
    });

    testWidgets('calls next step when continue button is clicked',
        (tester) async {
      const key = ValueKey('budget_advance_button_key');

      await setupApp(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      verify(() => mockBookingBloc.add(BookingNextStepEvent()));
    });
  });
}
