extension StreamExtensions<T, E> on Stream<T> {
  Future<T?> firstOrNull([bool Function(T)? predicate]) {
    Future<T?> future;
    if (predicate == null) {
      // (see (https://github.com/dart-lang/sdk/issues/48667))
      // ignore: unnecessary_cast
      future = first.then((value) => value as T?);
    } else {
      // (see (https://github.com/dart-lang/sdk/issues/48667))
      // ignore: unnecessary_cast
      future = firstWhere(predicate).then((value) => value as T?);
    }

    return future.catchError((error) {
      if (error is StateError) {
        return null;
      } else {
        throw error;
      }
    });
  }
}
