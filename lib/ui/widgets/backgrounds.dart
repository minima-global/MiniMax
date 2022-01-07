import 'package:flutter/material.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/dimensions.dart';

Widget withGlossyBackground({required Widget child}) {
  return Stack(
    children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageKeys.glossyBrightBackground),
            fit: BoxFit.cover,
          ),
        ),
      ),
      child,
    ],
  );
}

Widget semiTransparentModal({required Widget child, Color? colour}) {
  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(mainModalRadius)),
    child: Container(
      color: colour ?? white.withOpacity(0.5),
      child: child,
    ),
  );
}

Widget allDoneModal({required Widget child}) {
  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(mainModalRadius)),
    child: Container(
      color: allDone.withOpacity(0.9),
      child: child,
    ),
  );
}

