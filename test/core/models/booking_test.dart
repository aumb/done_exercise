import 'package:done_exercise/core/models/booking.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Booking', () {
    test('copy with name returns correct model', () {
      final originalBooking = Booking.empty;
      const fullName = 'test';

      final result = originalBooking.copyWith(fullName: fullName);

      expect(result.fullName, equals(fullName));
    });

    test('copy with budget returns correct model', () {
      final originalBooking = Booking.empty;
      const budget = 'test1';

      final result = originalBooking.copyWith(budget: budget);

      expect(result.budget, equals(budget));
    });
  });
}
