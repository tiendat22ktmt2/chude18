// lib/bloc/counter_event.dart
abstract class CounterEvent {}

class IncrementPressed extends CounterEvent {}
class DecrementPressed extends CounterEvent {}
class ResetPressed extends CounterEvent {}
