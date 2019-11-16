class Status {

  final Map<int, bool> _status = {};

  bool status(int meal) {
    return _status[meal] ?? false;
  }

  void change(int meal, bool value) {
    _status[meal] = value;
  }
}