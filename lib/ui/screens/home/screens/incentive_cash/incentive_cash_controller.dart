import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_tab.dart';

class IncentiveCashController extends GetxController {
  final MinimaStorage _storage;

  final Rx<IncentiveCashTab> selectedTab = Rx(IncentiveCashTab.values.first);
  final Rxn<String> nodeId = Rxn<String>();

  final TextEditingController nodeIdController = TextEditingController();

  IncentiveCashController(this._storage);

  @override
  void onInit() {
    super.onInit();

    _updateNodeId();
  }

  void _updateNodeId() {
    _storage.getNodeId()
        .then((value) => nodeId(value));
  }

  void selectTab(IncentiveCashTab tab) {
    selectedTab(tab);
  }

  void saveNodeId() {
    _storage //
        .setNodeId(nodeIdController.text)
        .then((_) => _updateNodeId());
  }
}
