import 'package:bloc_test/bloc_test.dart';
import 'package:done_exercise/core/blocs/booking/booking_bloc.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/forms/booking_name_form_body.dart';
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
    when(() => mockBookingBloc.state).thenReturn(
      const BookingState(
        bookingStep: BookingStep.name,
      ),
    );
    await tester.pumpApp(
      Scaffold(
        body: BookingNameFormBody(
          bloc: mockBookingBloc,
        ),
      ),
    );
  }

  group('BookingNameFormBody', () {
    group('Paint widget', () {
      testWidgets('renders name intro text', (tester) async {
        const key = ValueKey('name_intro_text_key');
        await setupApp(tester);
        await tester.pumpAndSettle();
        expect(find.byKey(key), findsOneWidget);
      });

      testWidgets('renders name text form field', (tester) async {
        const key = ValueKey('name_form_field_key');
        await setupApp(tester);
        await tester.pumpAndSettle();
        expect(find.byKey(key), findsOneWidget);
      });

      testWidgets('renders contiue button', (tester) async {
        const key = ValueKey('name_form_button_key');
        await setupApp(tester);
        await tester.pumpAndSettle();
        expect(find.byKey(key), findsOneWidget);
      });
    });

    group('TextField', () {
      testWidgets('renders error when name is empty', (tester) async {
        const buttonKey = ValueKey('name_form_button_key');

        when(() => mockBookingBloc.fullName).thenReturn('');

        await setupApp(tester);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(buttonKey));
        await tester.pumpAndSettle();

        expect(find.text(Strings.nameError), findsOneWidget);
        verifyNever(() => mockBookingBloc.add(BookingNextStepEvent()));
      });

      testWidgets('adds BookingNameFormEvent to bloc', (tester) async {
        const textFieldkey = ValueKey('name_form_field_key');

        when(() => mockBookingBloc.fullName).thenReturn('');

        await setupApp(tester);
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(textFieldkey), 'test');
        await tester.pumpAndSettle();

        verify(
          () => mockBookingBloc.add(
            const BookingNameFormEvent(name: 'test'),
          ),
        );
      });
    });

    testWidgets('adds BookingNextStepEvent to bloc', (tester) async {
      const buttonKey = ValueKey('name_form_button_key');

      when(() => mockBookingBloc.fullName).thenReturn('t');

      await setupApp(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(buttonKey));
      await tester.pumpAndSettle();

      verify(
        () => mockBookingBloc.add(
          BookingNextStepEvent(),
        ),
      );
    });
  });
}
