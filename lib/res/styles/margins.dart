import 'package:flutter/material.dart';

const double small3 = 4.0;
const double small2 = 8.0;
const double small1 = 12.0;
const double medium = 16.0;
const double large1 = 24.0;
const double large2 = 32.0;
const double large3 = 40.0;
const double large4 = 48.0;
const double large5 = 56.0;
const double large6 = 64.0;
const double large7 = 84.0;
const double large8 = 102.0;

extension MarginExtensions on double {
  Widget toSpace({bool horizontally = true, bool vertically = true}) {
    assert(horizontally != false || vertically != false);
    return SizedBox(
      width: horizontally ? this : 0,
      height: vertically ? this : 0,
    );
  }
}
