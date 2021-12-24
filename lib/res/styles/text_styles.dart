import 'package:flutter/material.dart';

TextStyle lmBodyCopy = const TextStyle(
  fontFamily: _manrope,
  fontSize: 16,
  fontWeight: FontWeight.w400,
  height: 1.5,
  letterSpacing: 0.02,
);

TextStyle lmBodyCopyMedium = lmBodyCopy.copyWith(fontSize: 14);

TextStyle lmH2 = const TextStyle(
  fontFamily: _manrope,
  fontSize: 16,
  fontWeight: FontWeight.w700,
  height: 1.5,
  letterSpacing: 0.02,
);

TextStyle lmH1 = const TextStyle(
  fontFamily: _manrope,
  fontSize: 24,
  fontWeight: FontWeight.w700,
  height: 1.5,
  letterSpacing: 0.02,
);

TextStyle lmH4 = const TextStyle(
  fontFamily: _manrope,
  fontSize: 14,
  fontWeight: FontWeight.w700,
  height: 1.5,
  letterSpacing: 0.01,
);

TextStyle lmH4Xtra = lmH4.copyWith(fontWeight: FontWeight.w800);

const _manrope = "manrope";
