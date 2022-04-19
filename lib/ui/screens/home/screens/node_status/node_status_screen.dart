import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/home_screen.dart';
import 'package:minimax/ui/screens/home/model/home_args.dart';
import 'package:minimax/ui/screens/home/screens/battery_optimisation/battery_optimisation_screen.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_model.dart';
import 'package:minimax/ui/screens/home/screens/node_status/model/node_status_model.dart';
import 'package:minimax/ui/screens/home/screens/node_status/node_status_controller.dart';
import 'package:minimax/ui/utils/consumer.dart';
import 'package:minimax/ui/utils/simple_html_text.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/status.dart';
import 'package:minimax/utils/extensions/object_extensions.dart';
import 'package:minimax/utils/extensions/rx_extensions.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';

class NodeStatusScreen extends GetWidget<NodeStatusController> {
  static const String routeName = "/home/node_status";

  const NodeStatusScreen({Key? key}) : super(key: key);

  Consumer<bool>? get _wasAlreadyConnectedConsumer => cast<HomeArgs>(Get.arguments)?.consumer;

  @override
  Widget build(BuildContext context) {
    _setShouldEnableRPC();

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () => controller.refreshState().whenComplete(HapticFeedback.heavyImpact),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(vertical: large2, horizontal: large1),
              child: semiTransparentModal(
                child: Padding(
                  padding: const EdgeInsets.all(medium),
                  child: _buildMainInfo(),
                ),
              ),
            ),
          ]),
        )
      ],
    );
  }

  Widget _buildMainInfo() {
    return Column(
      children: [
        _buildNodeStatus(),
        medium.toSpace(),
        _buildBatteryOptimisationStatus(),
        medium.toSpace(),
        _buildIncentiveCashStatus(),
        medium.toSpace(),
        _buildLastPing(),
      ],
    );
  }

  Widget _buildBatteryOptimisationStatus() {
    return controller.batteryOptimisation.buildMapped(
      (bool? batteryOptimisation) => batteryOptimisation?.status ?? Status.unknown,
      (Status status) => semiTransparentModal(
        child: buildStatusWidget(
          title: (_) => StringKeys.batteryOptimisationCardTitle.tr,
          textWidget: _buildLoadingText(status, status.allowedText, false),
          status: status,
          initiallyLoading: false,
          actionRequiredIfInactive: simpleHtmlText(
            StringKeys.batteryOptimisationCardActionRequired.tr,
            onLinkTap: (_) => Get.toNamed(BatteryOptimisationScreen.routeName, id: navigatorId),
          ),
        ),
      ),
    );
  }

  Widget _buildLastPing() {
    return controller.incentiveCashModel.buildIgnoreNull(
      (_model) => semiTransparentModal(
        child: Padding(
          padding: const EdgeInsets.all(medium),
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Text(
                  StringKeys.incentiveCashScreenBalancePingTitle.tr,
                  style: lmH4Xtra.copyWith(
                    color: coreBlackContrast,
                  ),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: _model.lastPing.let((lastPing) =>
                                DateFormat(StringKeys.incentiveCashScreenBalancePingDateFormat1.tr).format(lastPing)) ??
                            "",
                        style: lmBodyCopy.copyWith(color: coreBlackContrast),
                      ),
                      TextSpan(
                        text: _model.lastPing.let((lastPing) => DateFormat(StringKeys
                                .incentiveCashScreenBalancePingDateFormat2
                                .trArgs([lastPing.timeZoneName])).format(lastPing)) ??
                            "",
                        style: lmBodyCopy.copyWith(color: coreGrey100),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNodeStatus() {
    return controller.nodeStatusActive.buildMapped(
      (NodeStatusModel? nodeStatusActive) => nodeStatusActive?.active.status ?? Status.unknown,
      (Status nodeStatusActive) => semiTransparentModal(
        child: controller.initiallyLoading.build(
          (initiallyLoading) => buildStatusWidget(
            title: (_) => StringKeys.nodeStatusCardTitle.tr,
            textWidget: _buildLoadingText(nodeStatusActive, nodeStatusActive.statusText, initiallyLoading),
            status: nodeStatusActive,
            initiallyLoading: initiallyLoading,
            actionRequiredIfInactive: simpleHtmlText(StringKeys.nodeStatusCardInactiveActionRequired.tr),
          ),
        ),
      ),
    );
  }

  Widget _buildIncentiveCashStatus() {
    return controller.incentiveCashModel.buildMapped(
      (IncentiveProgramModel? incentiveCashModel) => incentiveCashModel?.status ?? Status.unknown,
      (Status status) => semiTransparentModal(
        child: controller.initiallyLoading.build(
          (initiallyLoading) => buildStatusWidget(
            title: (_) => StringKeys.incentiveCashCardTitle.tr,
            textWidget: _buildLoadingText(status, status.connectionText, initiallyLoading),
            status: status,
            initiallyLoading: initiallyLoading,
            actionRequiredIfInactive: simpleHtmlText(StringKeys.incentiveCashCardInactiveActionRequired.tr),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingText(Status status, String statusText, bool initiallyLoading) {
    final Widget realTextWidget = AutoSizeText(
      statusText,
      style: lmBodyCopyMedium.copyWith(color: coreBlackContrast),
      maxLines: 1,
      minFontSize: 0,
    );
    switch (status) {
      case Status.active:
        return realTextWidget;
      case Status.inactive:
      case Status.unknown:
        if (initiallyLoading) {
          return Text(
            StringKeys.nodeStatusLoading.tr,
            style: lmBodyCopyMedium.copyWith(color: coreBlackContrast),
          );
        } else {
          return realTextWidget;
        }
    }
  }

  void _setShouldEnableRPC() {
    final bool? wasAlreadyConnected = _wasAlreadyConnectedConsumer?.get();
    if (wasAlreadyConnected != null) {
      controller.setShouldEnableRPC(!wasAlreadyConnected);
    }

  }
}
