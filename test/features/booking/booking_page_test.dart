import 'package:bloc_test/bloc_test.dart';
import 'package:done_exercise/core/blocs/booking/booking_bloc.dart';
import 'package:done_exercise/features/booking/booking_page.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/booking_bottom_sheet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

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

  group('BookingPage', () {
    testWidgets('renders BookingView', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: mockBookingBloc,
          child: const BookingPage(),
        ),
      );
      expect(find.byType(BookingView), findsOneWidget);
    });
  });

  group('BookingView', () {
    testWidgets('renders BookingBottomSheetPage when button is clicked',
        (tester) async {
      const key = ValueKey('start_booking_key');
      await tester.pumpApp(
        BlocProvider.value(
          value: mockBookingBloc,
          child: const BookingView(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      expect(find.byType(BookingBottomSheetPage), findsOneWidget);
    });
  });
}
