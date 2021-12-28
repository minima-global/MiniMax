import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/help/views/utils/help_card.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpDevWidget extends StatelessWidget {
  const HelpDevWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: buildCard(
                text: StringKeys.helpScreenTileDiscord.tr,
                imageAsset: ImageKeys.icDiscord,
                onTap: () => launch(StringKeys.helpScreenLinkDiscord.tr),
              ),
            ),
            small2.toSpace(),
            Flexible(
              child: buildCard(
                text: StringKeys.helpScreenTileGithub.tr,
                imageAsset: ImageKeys.icGithub,
                onTap: () => launch(StringKeys.helpScreenLinkGithub.tr),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
