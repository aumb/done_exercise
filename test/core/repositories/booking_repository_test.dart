import 'package:done_exercise/core/repositories/booking_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BookingRepository bookingRepository;

  setUp(() {
    bookingRepository = BookingRepository();
  });

  group('BookingRepository', () {
    test('returns true if sucessfull', () async {
      final result = await bookingRepository.postBooking();

      expect(result, equals(true));
    });
  });
}
