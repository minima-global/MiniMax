import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';

Widget buildStatusWidget({
  required String Function(Status) title,
  required Widget textWidget,
  required Status status,
  required Widget actionRequiredIfInactive,
  bool initiallyLoading = false,
}) {
  return Padding(
    padding: const EdgeInsets.all(medium),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              title(status),
              style: lmH4Xtra.copyWith(color: coreBlackContrast),
            ),
            Expanded(child: textWidget),
            small2.toSpace(),
            if (!initiallyLoading || status == Status.active)
              SvgPicture.asset(
                ImageKeys.icRadialSelected,
                width: 24,
                height: 24,
                color: _colourForIcon(status),
              ),
          ],
        ),
        if (status == Status.inactive && !initiallyLoading) _buildActionRequired(actionRequiredIfInactive),
      ],
    ),
  );
}

Widget _buildActionRequired(Widget actionRequired) {
  return Column(
    children: [
      medium.toSpace(),
      Container(
        width: double.maxFinite,
        height: 1,
        color: coreGrey40,
      ),
      small1.toSpace(),
      SizedBox(
        width: double.maxFinite,
        child: Text(StringKeys.statusCardActionRequiredTitle.tr, style: lmH4Xtra.copyWith(color: coreBlackContrast)),
      ),
      small2.toSpace(),
      SizedBox(
        width: double.maxFinite,
        child: actionRequired,
      ),
    ],
  );
}

Color _colourForIcon(Status status) {
  switch (status) {
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

extension StatusExtensions on Status {
  String get statusText {
    switch (this) {
      case Status.active:
        return StringKeys.incentiveCashScreenBalanceStatusConnected.tr;
      case Status.inactive:
        return StringKeys.incentiveCashScreenBalanceStatusOffline.tr;
      case Status.unknown:
        return "";
    }
  }

  String get connectionText {
    switch (this) {
      case Status.active:
        return StringKeys.incentiveCashScreenBalanceStatusConnected.tr;
      case Status.inactive:
        return StringKeys.incentiveCashScreenBalanceStatusNotConnected.tr;
      case Status.unknown:
        return "";
    }
  }

  String get allowedText {
    switch (this) {
      case Status.active:
        return StringKeys.incentiveCashScreenBalanceStatusConnected.tr;
      case Status.inactive:
        return StringKeys.incentiveCashScreenBalanceStatusNotConnected.tr;
      case Status.unknown:
        return "";
    }
  }

  String get apkVersionText {
    switch (this) {
      case Status.active:
        return StringKeys.apkCardStatusUpToDate.tr;
      case Status.inactive:
        return StringKeys.apkCardStatusOutOfDate.tr;
      case Status.unknown:
        return "";
    }
  }
}

extension StatusBoolExtensions on bool {
  Status get status {
    if (this) {
      return Status.active;
    } else {
      return Status.inactive;
    }
  }
}
