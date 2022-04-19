class Consumer<T> {
  final T _data;

  Consumer(this._data);

  bool _consumed = false;

  T? get() {
    if (_consumed) {
      return null;
    }
    _consumed = true;
    return _data;
  }
}