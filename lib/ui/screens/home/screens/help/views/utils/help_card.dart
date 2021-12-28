import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/utils/extensions/object_extensions.dart';

const double _iconSize = 44;

@protected
Widget buildCard({
  required String text,
  String? imageAsset,
  Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: semiTransparentModal(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: medium),
        height: 73,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: small2),
                child: AutoSizeText(
                  text,
                  style: lmH2.copyWith(color: coreBlackContrast),
                  maxLines: 1,
                  minFontSize: 0,
                ),
              ),
            ),
            imageAsset?.let(
                  (imageAsset) => SvgPicture.asset(imageAsset, width: _iconSize, height: _iconSize),
                ) ??
                const SizedBox(width: _iconSize, height: _iconSize),
          ],
        ),
      ),
    ),
  );
}
