import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension WidgetRxExtensions<T, R> on Rx<T> {
  ObxValue build(Widget Function(T) builder) {
    return ObxValue<Rx<T>>((Rx<T> a) {
      return builder(a.value);
    }, this);
  }

  ObxValue buildMapped(
    R Function(T) transform,
    Widget Function(R) builder,
  ) {
    return ObxValue<Rx<T>>((Rx<T> a) {
      return builder(transform(a.value));
    }, this);
  }
}

extension WidgetRxBoolExtensions<R> on RxBool {
  ObxValue buildOnBuildChange({required Widget Function() onTrue, required Widget Function() onFalse}) {
    return ObxValue<RxBool>((RxBool a) {
      if (a.isTrue) {
        return onTrue();
      } else {
        return onFalse();
      }
    }, this);
  }
}

extension WidgetRxListExtensions<T> on RxList<T> {
  ObxValue build(Widget Function(List<T>) builder) {
    return ObxValue<RxList<T>>((RxList<T> a) {
      return builder(a.toList());
    }, this);
  }
}

extension WidgetRxSetExtensions<T> on RxSet<T> {
  ObxValue build(Widget Function(Set<T>) builder) {
    return ObxValue<RxSet<T>>((RxSet<T> a) {
      return builder(a.toSet());
    }, this);
  }
}
