import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/utils/extensions/object_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

Widget simpleHtmlText(String text, {TextStyle? style}) {
  return Html(
    data: text,
    onLinkTap: (String? url, _, __, ___) => url?.let((url) => launch(url)),
    tagsList: Html.tags..removeWhere((element) => ["img", "figure"].contains(element)),
    style: {
      "body": Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
      "ol": Style.fromTextStyle(style ?? lmBodyCopyMedium.copyWith(color: coreBlackContrast)),
      "li": Style.fromTextStyle(style ?? lmBodyCopyMedium.copyWith(color: coreBlackContrast)).copyWith(
        padding: const EdgeInsets.only(top: 2.25, left: 5, right: 5),
      ),
      "html": Style.fromTextStyle(style ?? lmBodyCopyMedium.copyWith(color: coreBlackContrast)),
      "p": Style(margin: EdgeInsets.zero, padding: const EdgeInsets.only(top: small2)),
      "b": Style.fromTextStyle(lmH4.copyWith(color: coreBlackContrast))
    },
  );
}
