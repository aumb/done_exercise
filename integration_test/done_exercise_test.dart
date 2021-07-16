import 'package:done_exercise/components/animated_progress_bar.dart';
import 'package:done_exercise/components/custom_activity_indicator.dart';
import 'package:done_exercise/components/custom_dialog.dart';
import 'package:done_exercise/features/booking/booking_page.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/booking_bottom_sheet_page.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/forms/booking_budget_form_body.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/forms/booking_summary_form_body.dart';
import 'package:done_exercise/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:done_exercise/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const startBookigKey = ValueKey('start_booking_key');
  const textFieldKey = ValueKey('name_form_field_key');
  const nameContinueButtonKey = ValueKey('name_form_button_key');
  const budgetAdvanceButtonKey = ValueKey('budget_advance_button_key');
  const confirmBookingButtonKey = ValueKey('confirm_booking_button_key');
  const bookingCompleteButtonKey = ValueKey('booking_complete_button_key');
  const cancelKey = ValueKey('cancel_booking_button_key');
  const titleKey = ValueKey('title_text_key');

  Future<void> setupApp(WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
  }

  group('App', () {
    testWidgets('renders BookingPage', (WidgetTester tester) async {
      await setupApp(tester);
      expect(find.byType(BookingPage), findsOneWidget);
    });

    testWidgets('renders start booking button', (WidgetTester tester) async {
      await setupApp(tester);
      expect(find.byKey(startBookigKey), findsOneWidget);
    });

    group(('BookingBottomSheetPage'), () {
      Future<void> setupBottomSheet(WidgetTester tester) async {
        await setupApp(tester);
        await tester.tap(find.byKey(startBookigKey));
        await tester.pumpAndSettle();
      }

      Future<void> moveToBudget(WidgetTester tester) async {
        await tester.enterText(find.byKey(textFieldKey), 'test');
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(nameContinueButtonKey));
        await tester.pumpAndSettle();
      }

      Future<void> moveToSummary(WidgetTester tester) async {
        await moveToBudget(tester);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(budgetAdvanceButtonKey));
        await tester.pumpAndSettle();
      }

      testWidgets('renders BookingBottomSheetPage',
          (WidgetTester tester) async {
        await setupBottomSheet(tester);
        expect(find.byType(BookingBottomSheetPage), findsOneWidget);
      });

      testWidgets('pops BookingBottomSheetPage', (WidgetTester tester) async {
        await setupBottomSheet(tester);
        expect(find.byType(BookingBottomSheetPage), findsOneWidget);
        await tester.tap(find.byKey(cancelKey));
        await tester.pumpAndSettle();
        expect(find.byType(BookingBottomSheetPage), findsNothing);
      });

      group('Steps', () {
        group('Progress', () {
          testWidgets('renders 1/3 progress when on name step', (tester) async {
            await setupBottomSheet(tester);
            final indicator =
                tester.firstWidget(find.byType(AnimatedProgressBar))
                    as AnimatedProgressBar;
            expect(indicator.fraction, equals(1 / 3));
          });
          testWidgets('renders 2/3 progress when on budget step',
              (tester) async {
            await setupBottomSheet(tester);
            await moveToBudget(tester);

            final indicator =
                tester.firstWidget(find.byType(AnimatedProgressBar))
                    as AnimatedProgressBar;

            expect(indicator.fraction, equals(2 / 3));
          });

          testWidgets('renders 3/3 progress when on summary step',
              (tester) async {
            await setupBottomSheet(tester);
            await moveToSummary(tester);

            final indicator =
                tester.firstWidget(find.byType(AnimatedProgressBar))
                    as AnimatedProgressBar;

            expect(indicator.fraction, equals(3 / 3));
          });
        });

        group('Name step', () {
          testWidgets('renders name title', (tester) async {
            await setupBottomSheet(tester);
            final text = tester.firstWidget(find.byKey(titleKey)) as Text;
            expect(find.byKey(titleKey), findsOneWidget);
            expect(text.data, equals(Strings.name));
          });

          testWidgets('shows error when name is not valid', (tester) async {
            await setupBottomSheet(tester);
            await tester.tap(find.byKey(nameContinueButtonKey));
            await tester.pumpAndSettle();

            expect(find.text(Strings.nameError), findsOneWidget);
          });

          testWidgets('moves to budget step when name is valid',
              (tester) async {
            await setupBottomSheet(tester);
            await moveToBudget(tester);

            expect(find.byType(BookingBudgetFormBody), findsOneWidget);
          });
        });

        group('Budget step', () {
          testWidgets('renders budget title', (tester) async {
            await setupBottomSheet(tester);
            await moveToBudget(tester);
            final text = tester.firstWidget(find.byKey(titleKey)) as Text;
            expect(find.byKey(titleKey), findsOneWidget);
            expect(text.data, equals(Strings.budget));
          });

          testWidgets('moves to summary step when button is pressed',
              (tester) async {
            await setupBottomSheet(tester);
            await moveToSummary(tester);

            expect(find.byType(BookingSummaryFormBody), findsOneWidget);
          });
        });

        group('Summary step', () {
          testWidgets('renders summary title', (tester) async {
            await setupBottomSheet(tester);
            await moveToSummary(tester);
            final text = tester.firstWidget(find.byKey(titleKey)) as Text;
            expect(find.byKey(titleKey), findsOneWidget);
            expect(text.data, equals(Strings.summary));
          });

          testWidgets('renders loader and text when button is pressed',
              (tester) async {
            await setupBottomSheet(tester);
            await moveToSummary(tester);

            await tester.tap(find.byKey(confirmBookingButtonKey));
            await tester.pump();

            expect(find.byType(CustomActivityIndicator), findsOneWidget);
            expect(find.text(Strings.confirming), findsOneWidget);
          });

          testWidgets('renders CustomDialog when loading is sucessfull',
              (tester) async {
            await setupBottomSheet(tester);
            await moveToSummary(tester);

            await tester.tap(find.byKey(confirmBookingButtonKey));
            await tester.pumpAndSettle();

            expect(find.byType(CustomDialog), findsOneWidget);
          });
        });
      });

      group('Sucess Dialog', () {
        testWidgets('renders dialog title', (tester) async {
          await setupBottomSheet(tester);
          await moveToSummary(tester);

          await tester.tap(find.byKey(confirmBookingButtonKey));
          await tester.pumpAndSettle();

          expect(find.text(Strings.bookingComplete), findsOneWidget);
        });

        testWidgets('renders dimiss button', (tester) async {
          await setupBottomSheet(tester);
          await moveToSummary(tester);

          await tester.tap(find.byKey(confirmBookingButtonKey));
          await tester.pumpAndSettle();

          expect(find.byKey(bookingCompleteButtonKey), findsOneWidget);
        });

        testWidgets('renders BookingPage when dimiss button is clicked',
            (tester) async {
          await setupBottomSheet(tester);
          await moveToSummary(tester);

          await tester.tap(find.byKey(confirmBookingButtonKey));
          await tester.pumpAndSettle();

          await tester.tap(find.byKey(bookingCompleteButtonKey));
          await tester.pumpAndSettle();

          expect(find.byKey(bookingCompleteButtonKey), findsNothing);
        });
      });
    });
  });
}
