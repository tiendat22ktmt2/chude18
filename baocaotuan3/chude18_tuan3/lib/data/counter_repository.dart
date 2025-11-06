import 'package:shared_preferences/shared_preferences.dart';

class CounterRepository {
  int _counter = 0;
  int _min = -5;
  int _max = 10;

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

  //Cập nhật giới hạn và đưa counter về min, sau đó lưu lại
  Future<void> setLimits(int min, int max) async {
    _min = min;
    _max = max;

    // Nếu counter nằm ngoài khoảng thì sửa lại
    if (_counter > _max) _counter = _max;
    if (_counter < _min) _counter = _min;

    // Khi nhấn Set → counter trở về min
    _counter = _min;

    await saveToStorage(); // Lưu lại toàn bộ dữ liệu
  }

  int get value => _counter;
  int get min => _min;
  int get max => _max;


  static const _keyValue = 'counter_value';
  static const _keyMin = 'counter_min';
  static const _keyMax = 'counter_max';

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt(_keyValue) ?? _counter;
    _min = prefs.getInt(_keyMin) ?? _min;
    _max = prefs.getInt(_keyMax) ?? _max;

    if (_counter > _max) _counter = _max;
    if (_counter < _min) _counter = _min;
  }

  Future<void> saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyValue, _counter);
    await prefs.setInt(_keyMin, _min);
    await prefs.setInt(_keyMax, _max);
  }
}
