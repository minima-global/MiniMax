import 'package:flutter/material.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/dimensions.dart';
import 'package:minimax/res/styles/margins.dart';
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
      constraints: const BoxConstraints(minHeight: 44),
      decoration: BoxDecoration(
        color: backgroundColour,
        border: Border.all(color: borderColour, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(mainModalRadius)),
      ),
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
  Color? colour,
}) {
  return createCTA(
    text: text,
    backgroundColour: colour ?? primaryCTAColour,
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

Widget createRobotoButton({
  required String text,
  required Color colour,
  Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(small1),
      child: Text(
        text.toUpperCase(),
        style: button.copyWith(color: colour),
      ),
    ),
  );
}

const Color primaryCTAColour = coreBlue100;
