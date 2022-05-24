import 'dart:async';

import 'package:get/get.dart';
import 'package:minimax/data/dependencies/background.dart';
import 'package:minimax/data/dependencies/battery.dart';
import 'package:minimax/data/repositories/incentive_cash_repository.dart';
import 'package:minimax/data/repositories/node_status_repository.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_model.dart';
import 'package:minimax/ui/screens/home/screens/node_status/model/node_status_model.dart';

class NodeStatusController extends GetxController {
  final IncentiveCashRepository _incentiveCashRepository;
  final NodeStatusRepository _nodeStatusRepository;
  final BatteryProvider _batteryProvider;
  final BackgroundService _backgroundService;

  final Rxn<IncentiveProgramModel> incentiveCashModel = Rxn();
  final Rxn<bool> batteryOptimisation = Rxn();
  final Rxn<NodeStatusModel> nodeStatusActive = Rxn();
  final RxBool initiallyLoading = RxBool(true);

  NodeStatusController(
    this._incentiveCashRepository,
    this._nodeStatusRepository,
    this._batteryProvider,
    this._backgroundService,
  );

  bool _shouldEnableRPC = false;

  StreamSubscription? workingNodeSubscription;

  @override
  void onInit() {
    super.onInit();

    _refreshIncentiveCashStatus();
    _refreshNodeStatus();
    _refreshBatteryOptimisation();

    Future.delayed(const Duration(seconds: 5)).then((_) => initiallyLoading(false));
  }

  void _refreshIncentiveCashStatus() {
    _incentiveCashRepository
        .getIncentiveCashInfo()
        .then(incentiveCashModel)
        .catchError((_) => Future.delayed(const Duration(seconds: 1), _refreshNodeStatus));
  }

  void _refreshNodeStatus() {
    _nodeStatusRepository.getNodeStatus().then((nodeStatus) {
      if (!nodeStatus.infoAvailable) {
        /// Retry after 1 second if there are no blocks yet
        Future.delayed(const Duration(seconds: 1)).then((_) => _refreshNodeStatus());
      } else {
        _enableRPCIfPossible();
        // It's connected, to ensure connections, we're updating every 10 seconds
        workingNodeSubscription ??= Stream.periodic(const Duration(seconds: 10)).listen((_) => _refreshNodeStatus());
      }

      nodeStatusActive(nodeStatus);
    }).catchError((error) {
      nodeStatusActive(NodeStatusModel.notConnectedYet());
      return Future.delayed(const Duration(seconds: 1)).then((value) {
        _refreshNodeStatus();
        return null;
      });
    });
  }

  void _refreshBatteryOptimisation() {
    _batteryProvider //
        .isIgnoringBatteryOptimizationMethodName()
        .then(batteryOptimisation);
  }

  Future refreshState() {
    final List<Future> futures = [
      _nodeStatusRepository.getNodeStatus().then(nodeStatusActive),
      _incentiveCashRepository.getIncentiveCashInfo().then(incentiveCashModel),
    ];

    return Future.wait(futures);
  }

  @override
  void onClose() {
    super.onClose();
    workingNodeSubscription?.cancel().then((value) => workingNodeSubscription = null);
  }

  void setShouldEnableRPC(bool shouldEnableRPC) {
    _shouldEnableRPC = shouldEnableRPC;
  }

  void _enableRPCIfPossible() {
    if (_shouldEnableRPC) {
      _shouldEnableRPC = false;
      _backgroundService.enableRPC();
    }
  }
}
