import 'package:done_exercise/components/custom_dialog.dart';
import 'package:done_exercise/features/booking/widgets/booking_complete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('BookingCompleteDialog', () {
    testWidgets(('render CustomDialog'), (tester) async {
      await tester.pumpApp(const BookingCompleteDialog());
      expect(find.byType(CustomDialog), findsOneWidget);
    });

    testWidgets(('render booking complete text'), (tester) async {
      const key = ValueKey('booking_complete_text_key');
      await tester.pumpApp(const BookingCompleteDialog());
      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets(('render booking complete button'), (tester) async {
      const key = ValueKey('booking_complete_button_key');
      await tester.pumpApp(const BookingCompleteDialog());
      expect(find.byKey(key), findsOneWidget);
    });
  });
}
