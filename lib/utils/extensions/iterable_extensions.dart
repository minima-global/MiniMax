import 'package:ajbell/utils/extensions/object_extensions.dart' as ObjExt;

extension IterableExtensions<T, E> on Iterable<T> {
  T? firstOrNull([bool Function(T)? predicate]) {
    if (predicate == null) {
      return getOrNull(0);
    } else {
      try {
        return firstWhere(predicate);
      } on StateError {
        return null;
      }
    }
  }

  T? getOrNull(int index) {
    try {
      return elementAt(index);
    } catch (exception) {
      // Happening when the index is negative or it's out of bounds
      return null;
    }
  }

  T? minByOrNull(E Function(T t) selector) {
    final Iterator<T> thisIterator = iterator;
    if (!thisIterator.moveNext()) {
      return null;
    }
    T minElem = thisIterator.current;
    if (!thisIterator.moveNext()) {
      return minElem;
    }
    E minValue = selector(minElem);
    do {
      final T t = thisIterator.current;
      final E v = selector(t);
      if ((minValue as Comparable).compareTo(v) > 0) {
        minElem = t;
        minValue = v;
      }
    } while (thisIterator.moveNext());
    return minElem;
  }

  T? maxByOrNull(E Function(T t) selector) {
    final Iterator<T> thisIterator = iterator;
    if (!thisIterator.moveNext()) {
      return null;
    }
    T minElem = thisIterator.current;
    if (!thisIterator.moveNext()) {
      return minElem;
    }
    E minValue = selector(minElem);
    do {
      final T t = thisIterator.current;
      final E v = selector(t);
      if ((minValue as Comparable).compareTo(v) < 0) {
        minElem = t;
        minValue = v;
      }
    } while (thisIterator.moveNext());
    return minElem;
  }

  num sumBy(num Function(T t) selector) {
    num result = 0;
    forEach((e) {
      result += selector(e);
    });

    return result;
  }

  List<T> sortedBy(E Function(T t) selector) {
    return toList()
      ..sort((t1, t2) {
        final Comparable a = ObjExt.ObjectNullExt<T>(t1).cast<Comparable>(selector(t1)) ?? 0;
        final Comparable b = ObjExt.ObjectNullExt<T>(t2).cast<Comparable>(selector(t2)) ?? 0;

        return a.compareTo(b);
      });
  }

  Iterable<E> mapIndexed<E>(E Function(T, int) mapper) {
    final List<T> items = toList();
    return Iterable.generate(length, (index) => mapper(items[index], index));
  }

  void forEachIndexed(void Function(T element, int index) action) {
    final List<T> items = toList();
    for (final T element in items) {
      action(element, items.indexOf(element));
    }
  }
}

extension NullIterableExtensions<T> on Iterable<T?> {
  List<T> filterNotNull() {
    final List<T> notNullResult = [];
    forEach((element) {
      if (element != null) {
        notNullResult.add(element);
      }
    });

    return notNullResult;
  }
}
