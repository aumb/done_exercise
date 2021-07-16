import 'package:done_exercise/features/booking/booking_page.dart';
import 'package:done_exercise/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'helpers/helpers.dart';

void main() {
  testWidgets('renders App', (tester) async {
    await tester.pumpApp(const MyApp());
    expect(find.byType(BookingPage), findsOneWidget);
  });
}
