import 'package:bloc_test/bloc_test.dart';
import 'package:done_exercise/components/animated_progress_bar.dart';
import 'package:done_exercise/core/blocs/booking/booking_bloc.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/booking_bottom_sheet_body.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/booking_bottom_sheet_header.dart';
import 'package:done_exercise/features/booking/widgets/bottom_sheet/booking_bottom_sheet_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    when(() => mockBookingBloc.state).thenReturn(const BookingState());
    when(() => mockBookingBloc.stepIndex).thenReturn(0);
    await tester.pumpApp(
      BlocProvider.value(
        value: mockBookingBloc,
        child: const BookingBottomSheetView(),
      ),
    );
  }

  group('BookingBottomSheetPage', () {
    testWidgets('renders BookingBottomSheetView', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: mockBookingBloc,
          child: const BookingBottomSheetPage(),
        ),
      );

      expect(find.byType(BookingBottomSheetView), findsOneWidget);
    });

    testWidgets('renders BookingBottomSheetHeader', (tester) async {
      await setupApp(tester);
      expect(find.byType(BookingBottomSheetHeader), findsOneWidget);
    });

    testWidgets('renders AnimatedProgressBar', (tester) async {
      await setupApp(tester);
      expect(find.byType(AnimatedProgressBar), findsOneWidget);
    });

    testWidgets('renders BookingBottomSheetBody', (tester) async {
      await setupApp(tester);
      expect(find.byType(BookingBottomSheetBody), findsOneWidget);
    });
  });
}
