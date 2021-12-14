extension ObjectNullExt<T> on T? {
  R? let<R>(R Function(T that) op) {
    if (this == null) {
      return null;
    } else {
      return op(this!);
    }
  }

  T? takeIf(bool Function(T? element) test) {
    if (test(this)) {
      return this;
    } else {
      return null;
    }
  }

  T? cast<T>(x) => x is T ? x : null;
}

extension ObjectExtensions<T> on T {
  T also(Function(T that) op) {
    op(this);
    return this;
  }

  T? takeIf(bool test(T element)) {
    if (test(this)) {
      return this;
    } else {
      return null;
    }
  }
}
