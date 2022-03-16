// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

/// A Column that separates items
class SeparatedColumn extends Column {
  SeparatedColumn.withSeparationBuilder({
    required List<Widget> children,
    required Widget Function(int position) separatorBuilder,
    int separatorStartsAt = 0,
  }) : super(
          children: separatedChildren(
            children,
            separatorBuilder,
            separatorStartsAt,
          ),
        );

  SeparatedColumn.withSeparation({
    required List<Widget> children,
    required Widget separator,
    int separatorStartsAt = 0,
  }) : super(
          children: separatedChildren(
            children,
            (_) => separator,
            separatorStartsAt,
          ),
        );

  static List<Widget> separatedChildren(
    List<Widget> children,
    Widget Function(int position) separatorBuilder,
    int separatorStartsAt,
  ) {
    final List<Widget> childrenCopy = List.from(children);
    final List<Widget> result = List.from(children);
    for (int i = separatorStartsAt; i < childrenCopy.length - 1; i++) {
      result.insert(result.indexOf(childrenCopy[i]) + 1, separatorBuilder(i));
    }

    return result;
  }
}
