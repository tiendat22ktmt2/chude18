import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int value;
  final bool isMax;
  final bool isMin;

  const CounterState({
    required this.value,
    this.isMax = false,
    this.isMin = false,
  });

  CounterState copyWith({
    int? value,
    bool? isMax,
    bool? isMin,
  }) {
    return CounterState(
      value: value ?? this.value,
      isMax: isMax ?? this.isMax,
      isMin: isMin ?? this.isMin,
    );
  }

  @override
  List<Object?> get props => [value, isMax, isMin];

  @override
  String toString() =>
      'CounterState(value: $value, isMax: $isMax, isMin: $isMin)';
}
