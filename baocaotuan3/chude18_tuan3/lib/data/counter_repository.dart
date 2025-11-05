// lib/data/counter_repository.dart

// lib/data/counter_repository.dart
class CounterRepository {
  int _counter = 0;

  int increment() {
    if (_counter < 10) _counter++;
    return _counter;
  }

  int decrement() {
    if (_counter > -5) _counter--;
    return _counter;
  }

  int reset() {
    _counter = 0;
    return _counter;
  }

  int get value => _counter;
}
