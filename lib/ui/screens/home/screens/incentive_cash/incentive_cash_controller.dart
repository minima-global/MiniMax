import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/data/repositories/incentive_cash_repository.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_model.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_tab.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';

// TODO test this class
class IncentiveCashController extends GetxController {
  final MinimaStorage _storage;
  final IncentiveCashRepository _incentiveCashRepository;

  final Rxn<IncentiveCashTab> selectedTab = Rxn();
  final Rxn<String> nodeId = Rxn<String>();
  final RxBool loadingBalance = RxBool(false);
  final Rxn<IncentiveCashModel> incentiveCashModel = Rxn();
  final Rxn showAllDoneTrigger = Rxn();
  final RxBool lockedEdition = RxBool(true);

  final TextEditingController nodeIdController = TextEditingController();

  IncentiveCashController(this._storage, this._incentiveCashRepository);

  @override
  void onInit() {
    super.onInit();

    _updateNodeId();

    nodeId.listenWhenNotNull((nodeId) {
      nodeIdController.text = nodeId;
    });

    _selectFirstTab();
  }

  void _selectFirstTab() {
    _storage.getNodeId().then((value) {
      if (value == null) {
        selectedTab(IncentiveCashTab.setUpInstructions);
      } else {
        selectedTab(IncentiveCashTab.balance);
      }
    });
  }

  void _updateNodeId() {
    _storage.getNodeId().then((value) => nodeId(value));

    loadingBalance(true);
    _incentiveCashRepository.getIncentiveCashInfo().then((value) {
      incentiveCashModel(value);
    }).whenComplete(() => loadingBalance(false));
  }

  void selectTab(IncentiveCashTab tab) {
    selectedTab(tab);
  }

  void saveNodeId() {
    String newNodeId = nodeIdController.text;
    _storage.getNodeId().then((value) {
      if (value != newNodeId) {
        showAllDoneTrigger.trigger(null);
      }

      return _storage //
          .setNodeId(newNodeId)
          .then((_) => _updateNodeId());
    });
  }

  void toggleLock() {
    lockedEdition.toggle();
  }
}
