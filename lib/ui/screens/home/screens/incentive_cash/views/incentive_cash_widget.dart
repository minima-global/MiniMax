import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_model.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/status.dart';
import 'package:minimax/utils/extensions/object_extensions.dart';

class IncentiveCashWidget extends StatelessWidget {
  final IncentiveCashModel? _model;
  final bool _loading;

  const IncentiveCashWidget(this._model, this._loading);

  @override
  Widget build(BuildContext context) {
    return semiTransparentModal(
      child: Padding(
        padding: const EdgeInsets.all(medium),
        child: Column(
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
    );
  }

  Widget _buildStatus() {
    return semiTransparentModal(
      child: buildStatusWidget(
        title: (_) => StringKeys.incentiveCashScreenBalanceStatusTitle.tr,
        text: _statusText,
        status: _status(),
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

  String _statusText(Status status) {
    switch(status) {
      case Status.active:
        return StringKeys.incentiveCashScreenBalanceStatusConnected.tr;
      case Status.inactive:
        return StringKeys.incentiveCashScreenBalanceStatusOffline.tr;
      case Status.unknown:
        return "";
    }
  }
}
