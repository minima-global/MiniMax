import 'package:get/get.dart';
import 'package:minimax/data/repositories/incentive_cash_repository.dart';
import 'package:minimax/data/repositories/node_status_repository.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_model.dart';
import 'package:minimax/ui/screens/home/screens/node_status/model/node_status_model.dart';

class NodeStatusController extends GetxController {
  final IncentiveCashRepository _incentiveCashRepository;
  final NodeStatusRepository _nodeStatusRepository;

  final Rxn<IncentiveCashModel> incentiveCashModel = Rxn();
  final Rxn<NodeStatusModel> nodeStatusActive = Rxn();

  NodeStatusController(
    this._incentiveCashRepository,
    this._nodeStatusRepository,
  );

  @override
  void onInit() {
    super.onInit();

    _refreshIncentiveCashStatus();
    _refreshNodeStatus();
  }

  void _refreshIncentiveCashStatus() {
    _incentiveCashRepository
        .getIncentiveCashInfo()
        .then(incentiveCashModel)
        .catchError((_) => Future.delayed(const Duration(seconds: 1), _refreshNodeStatus));
  }

  void _refreshNodeStatus() {
    _nodeStatusRepository.getNodeStatus(refresh: false).then((nodeStatus) {
      if (!nodeStatus.infoAvailable) {
        /// Retry after 1 second if there are no blocks yet
        Future.delayed(const Duration(seconds: 1)).then((value) => _refreshNodeStatus());
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
}
