import 'dart:async';

import 'package:ajbell/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension RxnExtensions<T> on Rxn<T> {
  // When we want to listen for a non null value, Rxn isn't configured,
  // and this might simplify the syntax when reading
  StreamSubscription<T?> listenWhenNotNull(Function(T) onValue) {
    return listen((T? value) {
      value?.let((that) => onValue(that));
    });
  }
}

extension RxnStringExtensions on RxnString {
  // When we want to listen for a non null value, Rxn isn't configured,
  // and this might simplify the syntax when reading
  StreamSubscription<String?> listenWhenNotNull(Function(String) onValue) {
    return listen((String? value) {
      value?.let((that) => onValue(that));
    });
  }
}

extension WidgetRxnExtensions<T> on Rxn<T> {
  ObxValue build(Widget Function(T?) builder) {
    return ObxValue<Rx<T?>>((Rx<T?> a) {
      return builder(a.value);
    }, this);
  }

  ObxValue buildIgnoreNull(Widget Function(T) builder, {Widget defaultIfNull = const SizedBox()}) {
    return ObxValue<Rx<T?>>((Rx<T?> a) {
      return a.value?.let((that) => builder(that)) ?? defaultIfNull;
    }, this);
  }
}

extension WidgetRxnStringExtensions on RxnString {
  ObxValue build(Widget Function(String?) builder) {
    return ObxValue<RxnString>((RxnString a) {
      return builder(a.value);
    }, this);
  }

  ObxValue buildIgnoreNull(Widget Function(String) builder, {Widget defaultIfNull = const SizedBox()}) {
    return ObxValue<RxnString>((RxnString a) {
      return a.value?.let((that) => builder(that)) ?? defaultIfNull;
    }, this);
  }
}
