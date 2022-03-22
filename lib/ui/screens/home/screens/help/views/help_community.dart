import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/help/views/utils/help_card.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCommunityWidget extends StatelessWidget {
  const HelpCommunityWidget({Key? key}) : super(key: key);

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
                text: StringKeys.helpScreenTileTelegram.tr,
                imageAsset: ImageKeys.icTelegram,
                onTap: () => launch(StringKeys.helpScreenLinkTelegram.tr),
              ),
            ),
          ],
        ),
        small1.toSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: buildCard(
                text: StringKeys.helpScreenTileTwitter.tr,
                imageAsset: ImageKeys.icTwitter,
                onTap: () => launch(StringKeys.helpScreenLinkTwitter.tr),
              ),
            ),
            small2.toSpace(),
            Flexible(
              child: buildCard(
                text: StringKeys.helpScreenTileYoutube.tr,
                imageAsset: ImageKeys.icYoutube,
                onTap: () => launch(StringKeys.helpScreenLinkYoutube.tr),
              ),
            ),
          ],
        ),
        small1.toSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: buildCard(
                text: StringKeys.helpScreenTileWebsite.tr,
                imageAsset: ImageKeys.icMinimaCircle,
                onTap: () => launch(StringKeys.helpScreenLinkWebsite.tr),
              ),
            ),
            small2.toSpace(),
            Flexible(
              child: buildCard(
                text: StringKeys.helpScreenTileBlogs.tr,
                imageAsset: ImageKeys.icMinimaCircle,
                onTap: () => launch(StringKeys.helpScreenLinkBlogs.tr),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
