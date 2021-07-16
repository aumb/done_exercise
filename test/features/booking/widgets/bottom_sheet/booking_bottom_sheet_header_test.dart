import 'package:bloc_test/bloc_test.dart';
import 'package:done_exercise/core/blocs/booking/booking_bloc.dart';
import 'package:done_exercise/core/models/booking.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/booking_bottom_sheet_header.dart';
import 'package:done_exercise/utils/strings.dart';
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
      Scaffold(body: BookingBottomSheetHeader(bloc: mockBookingBloc)),
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
  }

  void setupStepThree() {
    when(() => mockBookingBloc.state).thenReturn(BookingState(
      bookingStep: BookingStep.summary,
      booking: Booking.empty.copyWith(fullName: 'test', budget: 'test1'),
    ));
    when(() => mockBookingBloc.stepIndex).thenReturn(2);
  }

  group('BookingBottomSheetHeader', () {
    testWidgets('renders BookingBottomSheetHeader', (tester) async {
      setupStepOne();
      await setupApp(tester);
      expect(find.byType(BookingBottomSheetHeader), findsOneWidget);
    });

    testWidgets('adds BookingPreviousStepEvent to bloc', (tester) async {
      const key = ValueKey('booking_back_button_key');
      setupStepTwo();
      await setupApp(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      verify(() => mockBookingBloc.add(BookingPreviousStepEvent()));
    });

    group('renders correct title for step', () {
      const key = ValueKey('title_text_key');

      testWidgets('renders name text', (tester) async {
        setupStepOne();
        await setupApp(tester);
        await tester.pumpAndSettle();
        final text = tester.firstWidget(find.byKey(key)) as Text;
        expect(find.byKey(key), findsOneWidget);
        expect(text.data, equals(Strings.name));
      });

      testWidgets('renders budget text', (tester) async {
        setupStepTwo();
        await setupApp(tester);
        await tester.pumpAndSettle();
        final text = tester.firstWidget(find.byKey(key)) as Text;
        expect(find.byKey(key), findsOneWidget);
        expect(text.data, equals(Strings.budget));
      });

      testWidgets('renders summary text', (tester) async {
        setupStepThree();
        await setupApp(tester);
        await tester.pumpAndSettle();
        final text = tester.firstWidget(find.byKey(key)) as Text;
        expect(find.byKey(key), findsOneWidget);
        expect(text.data, equals(Strings.summary));
      });
    });
  });
}
