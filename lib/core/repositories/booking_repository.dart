abstract class BookingRepositoryContract {
  Future<void> postBooking();
}

class BookingRepository implements BookingRepositoryContract {
  @override
  Future<bool> postBooking() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
