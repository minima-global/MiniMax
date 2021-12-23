import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_model.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';

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
          ],
        ),
      ),
    );
  }

  Widget _buildBalance() {
    return Padding(
      padding: const EdgeInsets.all(medium),
      child: Column(
        children: [
          Text(
            StringKeys.incentiveCashScreenBalanceTitle.tr,
            style: lmH4Xtra.copyWith(
              color: coreBlackContrast,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPing() {
    return Padding(
      padding: const EdgeInsets.all(medium),
      child: Column(
        children: [
          Text(
            EN EL PING ME HE QUEDAO
            StringKeys.incentiveCashScreenBalanceTitle.tr,
            style: lmH4Xtra.copyWith(
              color: coreBlackContrast,
            ),
          )
        ],
      ),
    );
  }
}
