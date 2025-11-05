// lib/data/counter_repository.dart

class CounterRepository {
  int _counter = 0;
  int _min = -5; // giá trị mặc định
  int _max = 10; // giá trị mặc định

  int increment() {
    if (_counter < _max) _counter++;
    return _counter;
  }

  int decrement() {
    if (_counter > _min) _counter--;
    return _counter;
  }

  int reset() {
    _counter = _min;
    return _counter;
  }

  // 👉 Hàm mới: cho phép thay đổi giới hạn
  void setLimits(int min, int max) {
    _min = min;
    _max = max;

    // Nếu giá trị hiện tại nằm ngoài khoảng, đưa về giới hạn
    if (_counter > _max) _counter = _max;
    if (_counter < _min) _counter = _min;
     _counter = _min;
  }

  // Getter để truy cập khi cần
  int get value => _counter;
  int get min => _min;
  int get max => _max;
}
