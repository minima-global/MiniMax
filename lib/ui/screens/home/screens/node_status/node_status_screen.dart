import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/node_status/node_status_controller.dart';
import 'package:minimax/ui/utils/simple_html_text.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/status.dart';
import 'package:minimax/utils/extensions/rx_extensions.dart';

class NodeStatusScreen extends GetWidget<NodeStatusController> {
  static const String routeName = "/home/node_status";

  const NodeStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: large2, horizontal: large1),
        child: semiTransparentModal(
          child: Padding(
            padding: const EdgeInsets.all(medium),
            child: _buildMainInfo(),
          ),
        ),
      ),
    );
  }

  Widget _buildMainInfo() {
    return Column(
      children: [
        _buildInfo(),
        medium.toSpace(),
        _buildNodeStatus(),
        medium.toSpace(),
        _buildIncentiveCashStatus(),
        medium.toSpace(),
        _buildAPKVersion(),
      ],
    );
  }

  Widget _buildInfo() {
    return semiTransparentModal(
      child: Padding(
        padding: const EdgeInsets.all(medium),
        child: Column(
          children: [
            _buildNodeStatusTitle(),
            small1.toSpace(),
            _buildNodeStatusExplanation(),
          ],
        ),
      ),
    );
  }

  Widget _buildNodeStatusTitle() {
    return SizedBox(
      width: double.maxFinite,
      child: Text(
        StringKeys.nodeStatusTitle.tr,
        style: lmH4Xtra.copyWith(color: coreBlue100),
      ),
    );
  }

  Widget _buildNodeStatusExplanation() {
    return simpleHtmlText(StringKeys.nodeStatusExplanation.tr);
  }

  Widget _buildNodeStatus() {
    return controller.nodeStatusActive.buildMapped(
      (nodeStatusActive) => nodeStatusActive?.active.status ?? Status.unknown,
      (nodeStatusActive) => semiTransparentModal(
        child: buildStatusWidget(
          title: (_) => StringKeys.nodeStatusCardTitle.tr,
          text: (status) => status.statusText,
          status: nodeStatusActive,
          actionRequiredIfInactive: StringKeys.nodeStatusCardInactiveActionRequired.tr,
        ),
      ),
    );
  }

  Widget _buildIncentiveCashStatus() {
    return controller.incentiveCashModel.buildMapped(
      (incentiveCashModel) => incentiveCashModel?.status ?? Status.unknown,
      (status) => semiTransparentModal(
        child: buildStatusWidget(
          title: (_) => StringKeys.incentiveCashCardTitle.tr,
          text: (status) => status.connectionText,
          status: status,
          actionRequiredIfInactive: StringKeys.incentiveCashCardInactiveActionRequired.tr,
        ),
      ),
    );
  }

  Widget _buildAPKVersion() {
    return controller.nodeStatusActive.buildMapped(
      (nodeStatusActive) => nodeStatusActive?.apkUpToDate.status ?? Status.unknown,
      (status) => semiTransparentModal(
        child: buildStatusWidget(
          title: (_) => StringKeys.apkCardTitle.tr,
          text: (status) => status.apkVersionText,
          status: status,
          actionRequiredIfInactive: StringKeys.apkCardInactiveActionRequired.tr,
        ),
      ),
    );
  }
}
