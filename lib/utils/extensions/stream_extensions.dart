extension StreamExtensions<T, E> on Stream<T> {
  Future<T?> firstOrNull([bool Function(T)? predicate]) {
    Future<T?> future;
    if (predicate == null) {
      future = first;
    } else {
      future = firstWhere(predicate);
    }

    return future.then((v) => v, onError: (error) {
      if (error is StateError) {
        return null;
      } else {
        throw error;
      }
    });
  }
}
