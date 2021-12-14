import 'package:flutter/material.dart';

extension DoubleObjectExtensions<T> on T {
  MaterialStateProperty<T> toMaterialStateProperty() {
    return MaterialStateProperty.all(this);
  }
}
