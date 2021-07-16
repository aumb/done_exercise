import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  const Booking({
    required this.fullName,
    required this.budget,
  });

  final String fullName;
  final String budget;

  static const empty = Booking(
    fullName: '',
    budget: '',
  );

  Booking copyWith({
    String? fullName,
    String? budget,
  }) {
    return Booking(
      fullName: fullName ?? this.fullName,
      budget: budget ?? this.budget,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        budget,
      ];
}
