import 'package:flutter/material.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/dimensions.dart';
import 'package:minimax/res/styles/text_styles.dart';

Widget createCTA({
  Color backgroundColour = coreBlue100,
  Color textColour = white,
  Color borderColour = Colors.transparent,
  required String text,
  Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: backgroundColour,
        border: Border.all(color: borderColour, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(mainModalRadius)),
      ),
      height: 44,
      child: Center(
        child: Text(
          text,
          style: lmH4Xtra.copyWith(color: textColour),
        ),
      ),
    ),
  );
}

Widget createPrimaryCTA({
  required String text,
  Function()? onTap,
}) {
  return createCTA(
    text: text,
    backgroundColour: coreBlue100,
    textColour: white,
    onTap: onTap,
  );
}

Widget createSecondaryCTA({
  required String text,
  Function()? onTap,
}) {
  return createCTA(
    text: text,
    backgroundColour: transparent,
    textColour: coreBlue100,
    borderColour: coreBlue100,
    onTap: onTap,
  );
}
