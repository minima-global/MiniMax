import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:minimax/data/dependencies/background.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/ui/screens/decider/model/decider_model.dart';

class DeciderController extends GetxController {
  final Rxn<DeciderModel> decider = Rxn();

  final MinimaStorage _minimaStorage;
  final BackgroundService _backgroundService;

  DeciderController(this._minimaStorage, this._backgroundService);

  @override
  void onInit() {
    super.onInit();

    _minimaStorage.getUserConfiguredDeviceFirstTime() //
        .then((configured) {
      switch (configured) {
        case true:
          return decider(DeciderModel.goMain);
        case false:
          return decider(DeciderModel.setUp);
      }
    });

    _backgroundService.startBackgroundService();
  }
}
