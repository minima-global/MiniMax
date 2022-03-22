import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_model.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/views/invite_code_widget/invite_code_controller.dart';
import 'package:minimax/ui/utils/simple_html_text.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';

class InviteCodeWidget extends GetWidget<InviteCodeController> {
  final IncentiveProgramModel? _model;
  final bool _loading;

  const InviteCodeWidget(this._model, this._loading);

  @override
  Widget build(BuildContext context) {
    controller.copiedTrigger.listen(_onCopied);

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: ListView(
        shrinkWrap: true,
        children: [
          _buildInviteSentence(),
          medium.toSpace(),
          _buildTextFormField(),
        ],
      ),
    );
  }

  Widget _buildTextFormField() {
    return controller.inviteCode.buildIgnoreNull(
      (inviteCode) => semiTransparentModal(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: large1, horizontal: medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: medium),
                child: Text(
                  StringKeys.inviteCodeTextFormTitle.tr,
                  style: lmH4.copyWith(color: coreBlackContrast),
                ),
              ),
              small2.toSpace(),
              semiTransparentModal(
                child: Padding(
                  padding: const EdgeInsets.all(medium),
                  child: Row(
                    children: [
                      Expanded(
                        child: ExtendedText(
                          StringKeys.inviteCodeLink.trArgs([inviteCode]),
                          maxLines: 1,
                          overflowWidget: TextOverflowWidget(
                            child: Text("… ", style: lmH4.copyWith(color: coreGrey40)),
                            position: TextOverflowPosition.middle,
                          ),
                          style: lmH4.copyWith(color: coreBlackContrast),
                        ),
                      ),
                      InkWell(
                        onTap: () => controller.copyInviteCodeToClipboard(
                            textToCopy: StringKeys.inviteCodeLink.trArgs([inviteCode])
                        ),
                        child: const Padding(
                          padding: EdgeInsetsDirectional.only(start: small1),
                          child: Icon(
                            Icons.copy,
                            color: coreBlackContrast,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              medium.toSpace(),
              createPrimaryCTA(
                text: StringKeys.inviteCodeShareCTA.tr,
                onTap: () => controller.shareLink(
                  shareTitle: StringKeys.inviteCodeShareTitle.tr,
                  text: StringKeys.inviteCodeMessageToCopyToClipboard.trArgs([inviteCode]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInviteSentence() {
    return controller.inviteCode.build((inviteCode) {
      String text =
          (inviteCode == null) ? StringKeys.inviteCodeExplanation.tr : StringKeys.inviteCodeExplanationCodeEntered.tr;

      final Widget widget = semiTransparentModal(
        child: Padding(
          padding: const EdgeInsets.all(medium),
          child: simpleHtmlText(
            text,
          ),
        ),
      );
      // Don't remove this aberration, the html won't refresh.
      return inviteCode == null ? Container(child: widget) : widget;
    });
  }

  void _onCopied(_) {
    HapticFeedback.heavyImpact();
    Get.snackbar(
      StringKeys.inviteCodeCopiedSnackbarTitle.tr,
      StringKeys.inviteCodeCopiedSnackbarMessage.tr,
      backgroundColor: coreBlue100,
      colorText: white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
