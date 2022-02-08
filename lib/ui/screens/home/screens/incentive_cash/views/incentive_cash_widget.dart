import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_model.dart';
import 'package:minimax/ui/utils/simple_html_text.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/status.dart';
import 'package:minimax/utils/extensions/object_extensions.dart';

class IncentiveCashWidget extends StatelessWidget {
  final IncentiveProgramModel? _model;
  final bool _loading;
  final Future<void> Function() onRefresh;

  const IncentiveCashWidget(this._model, this._loading, {required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return semiTransparentModal(
      child: Padding(
        padding: const EdgeInsets.all(medium),
        child: RefreshIndicator(
          onRefresh: () {
            return onRefresh().then((_) => HapticFeedback.heavyImpact());
          },
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildBalance(),
                small1.toSpace(),
                _buildPing(),
                small1.toSpace(),
                _buildExplanation(),
                small1.toSpace(),
                _buildStatus(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatus() {
    return semiTransparentModal(
      child: buildStatusWidget(
        title: (_) => StringKeys.nodeStatusCardTitle.tr,
        textWidget: AutoSizeText(
          _status().statusText,
          style: lmBodyCopyMedium.copyWith(color: coreBlackContrast),
          maxLines: 1,
          minFontSize: 0,
        ),
        status: _status(),
        actionRequiredIfInactive: simpleHtmlText(StringKeys.nodeStatusCardInactiveActionRequired.tr),
      ),
    );
  }

  Widget _buildExplanation() {
    return Text(
      StringKeys.incentiveCashScreenBalanceExplanation.tr,
      style: lmBodyCopy.copyWith(
        color: coreBlackContrast,
      ),
    );
  }

  Widget _buildBalance() {
    return semiTransparentModal(
      child: Padding(
        padding: const EdgeInsets.all(medium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Text(
                StringKeys.incentiveCashScreenBalanceTitle.tr,
                style: lmH4Xtra.copyWith(
                  color: coreBlackContrast,
                ),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: Text(
                _model?.minimaBalance.toString() ?? "",
                style: lmBodyCopy.copyWith(
                  color: coreBlackContrast,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPing() {
    return semiTransparentModal(
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
                      text: _model?.lastPing.let((lastPing) =>
                              DateFormat(StringKeys.incentiveCashScreenBalancePingDateFormat1.tr).format(lastPing)) ??
                          "",
                      style: lmBodyCopy.copyWith(color: coreBlackContrast),
                    ),
                    TextSpan(
                      text: _model?.lastPing.let((lastPing) => DateFormat(
                                  StringKeys.incentiveCashScreenBalancePingDateFormat2.trArgs([lastPing.timeZoneName]))
                              .format(lastPing)) ??
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
    );
  }

  Status _status() {
    if (_loading) {
      return Status.unknown;
    } else if (_model == null) {
      return Status.inactive;
    } else {
      return Status.active;
    }
  }
}
