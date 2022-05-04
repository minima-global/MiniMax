import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/data/repositories/incentive_cash_repository.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_model.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_tab.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';

// TODO test this class
class IncentiveProgramController extends GetxController with GetSingleTickerProviderStateMixin {
  final MinimaStorage _storage;
  final IncentiveCashRepository _incentiveCashRepository;

  final Rxn<IncentiveProgramTab> selectedTab = Rxn();
  final Rxn<String> nodeId = Rxn<String>();
  final RxBool loadingBalance = RxBool(false);
  final Rxn<IncentiveProgramModel> incentiveCashModel = Rxn();
  final Rxn showAllDoneTrigger = Rxn();
  final RxBool lockedEdition = RxBool(true);
  final RxDouble inviteCodeOpacity = RxDouble(0.0);

  final TextEditingController nodeIdController = TextEditingController();
  late final AnimationController animationController;
  IncentiveProgramController(this._storage, this._incentiveCashRepository);

  @override
  void onInit() {
    super.onInit();
    _startAnimation();
    _updateNodeId();

    nodeId.listenWhenNotNull((nodeId) {
      nodeIdController.text = nodeId;
    });

    _selectFirstTab();
  }

  void _startAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),

    );
    CurveTween(
        curve: Curves.bounceInOut
    ).animate(animationController);
    animationController.repeat(reverse: true, period: const Duration(seconds: 1));
  }

  void _selectFirstTab() {
    _storage.getNodeId().then((value) {
      if (value == null) {
        selectedTab(IncentiveProgramTab.incentiveProgram);
      } else {
        selectedTab(IncentiveProgramTab.inviteLink);
      }
    });
  }

  void _updateNodeId() {
    _storage.getNodeId().then((value) => nodeId(value));

    refreshBalance();
  }

  Future<void> refreshBalance() {
    loadingBalance(true);
    _incentiveCashRepository.getIncentiveCashInfo().then((value) {
      incentiveCashModel(value);
    }).whenComplete(() => loadingBalance(false));
    return Future.value();
  }

  void selectTab(IncentiveProgramTab tab) {
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

  void restartOpacity() {
    inviteCodeOpacity((inviteCodeOpacity.value-1).abs());
  }

  void closeLock() {
    lockedEdition(true);
  }

}
