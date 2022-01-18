import 'package:flutter/material.dart';

TextStyle lmBodyCopy = const TextStyle(
  fontFamily: _manrope,
  fontSize: 16,
  fontWeight: FontWeight.w400,
  height: 1.5,
  letterSpacing: 0.2,
);

TextStyle lmBodyCopyMedium = lmBodyCopy.copyWith(fontSize: 14);
TextStyle lmBodyCopySmall = lmBodyCopy.copyWith(fontSize: 12);

TextStyle lmH2 = const TextStyle(
  fontFamily: _manrope,
  fontSize: 16,
  fontWeight: FontWeight.w700,
  height: 1.5,
  letterSpacing: 0.2,
);

TextStyle lmH3 = const TextStyle(
  fontFamily: _manrope,
  fontSize: 16,
  fontWeight: FontWeight.w700,
  height: 1.5,
  letterSpacing: 0.1,
);

TextStyle lmH1 = const TextStyle(
  fontFamily: _manrope,
  fontSize: 24,
  fontWeight: FontWeight.w700,
  height: 1.5,
  letterSpacing: 0.2,
);

TextStyle lmH4 = const TextStyle(
  fontFamily: _manrope,
  fontSize: 14,
  fontWeight: FontWeight.w700,
  height: 1.5,
  letterSpacing: 0.2,
);

TextStyle button = const TextStyle(
  fontFamily: _roboto,
  fontSize: 14,
  fontWeight: FontWeight.w500,
  height: 1.71,
  letterSpacing: 0.75,
);

TextStyle lmH4Xtra = lmH4.copyWith(fontWeight: FontWeight.w800);

const _manrope = "manrope";
const _roboto = "roboto";
