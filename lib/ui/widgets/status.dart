import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';

Widget buildStatusWidget({
  required String Function(Status) title,
  required String Function(Status) text,
  required Status status,
}) {
  return Padding(
    padding: const EdgeInsets.all(medium),
    child: Row(
      children: [
        Text(title(status), style: lmH4Xtra.copyWith(color: coreBlackContrast)),
        Text(text(status), style: lmBodyCopyMedium.copyWith(color: coreBlackContrast)),
        const Spacer(),
        SvgPicture.asset(
          ImageKeys.icRadialSelected,
          width: 24,
          height: 24,
          color: _colourForIcon(status),
        ),
      ],
    ),
  );
}

Color _colourForIcon(Status status) {
  switch(status) {
    case Status.active:
      return signsGreenGood;
    case Status.inactive:
      return signsWarning;
    case Status.unknown:
      return Colors.transparent;
  }
}

enum Status {
  active,
  inactive,
  unknown,
}
