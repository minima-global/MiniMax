import 'dart:convert';

import 'package:minimax/data/dependencies/background.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_model.dart';
import 'package:minimax/ui/utils/errors.dart';
import 'package:minimax/ui/widgets/status.dart';

abstract class IncentiveCashRepository {
  Future<IncentiveProgramModel> getIncentiveCashInfo();
}

class IncentiveCashRepositoryImpl extends IncentiveCashRepository {
  final MinimaStorage _storage;
  final BackgroundService _backgroundService;

  IncentiveCashRepositoryImpl(this._storage, this._backgroundService);

  @override
  Future<IncentiveProgramModel> getIncentiveCashInfo() {
    return _storage.getNodeId() //
        .then<IncentiveProgramModel>(
      (nodeId) {
        if (nodeId == null) {
          return IncentiveProgramModel.offline();
        } else {
          return _backgroundService.getIncentiveCashInfo(nodeId).then((value) {
            if (value == null) {
              return IncentiveProgramModel.offline();
            } else {
              Map<String, dynamic> json = jsonDecode(value);
              if (json.containsKey("status") && json.containsKey("response") && json["response"]["details"] != null) {
                Map<String, dynamic> details = json['response']['details'];
                Map<String, dynamic> rewards = details['rewards'];
                return IncentiveProgramModel(
                  status: (json['status'] as bool).status,
                  lastPing: DateTime.parse(details['lastPing'] as String),
                  minimaBalance: (rewards['dailyRewards'] as int) + (rewards['previousRewards'] as double),
                );
              } else {
                return IncentiveProgramModel.offline();
              }
            }
          });
        }
      },
    );
  }
}
