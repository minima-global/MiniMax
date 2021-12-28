import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/help/views/utils/help_card.dart';
import 'package:minimax/ui/screens/pdf_screen/pdf_screen.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';

class HelpTechPapersWidget extends StatelessWidget {
  const HelpTechPapersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCard(
          text: StringKeys.helpScreenTileMinimaWhitePaper.tr,
          onTap: () => Get.to(
                () => PDFScreen.fromUrl(
              url: StringKeys.helpScreenLinkMinimaWhitePaper.tr,
              title: StringKeys.helpScreenTileMinimaWhitePaper.tr,
            ),
          ),
        ),
        small1.toSpace(),
        buildCard(
          text: StringKeys.helpScreenTileTokenomicsPaper.tr,
          onTap: () => Get.to(
                () => PDFScreen.fromUrl(
              url: StringKeys.helpScreenLinkTokenomicsPaper.tr,
              title: StringKeys.helpScreenTileTokenomicsPaper.tr,
            ),
          ),
        ),
        small1.toSpace(),
        buildCard(
          text: StringKeys.helpScreenTileProtocolLayers.tr,
          onTap: () => Get.to(
                () => PDFScreen.fromUrl(
              url: StringKeys.helpScreenLinkProtocolLayers.tr,
              title: StringKeys.helpScreenTileProtocolLayers.tr,
            ),
          ),
        ),
      ],
    );
  }
}
