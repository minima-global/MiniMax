import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:minimax/data/dependencies/background.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/data/repositories/node_status_repository.dart';
import 'package:minimax/ui/screens/home/screens/node_status/model/node_status_model.dart';
import 'package:minimax/utils/extensions/stream_extensions.dart';

class LoaderController extends GetxController {
  final NodeStatusRepository _nodeStatusRepository;
  final BackgroundService _backgroundService;
  final MinimaStorage _storage;

  final Rxn connectedTrigger = Rxn();

  LoaderController(
    this._nodeStatusRepository,
    this._backgroundService,
    this._storage,
  );

  late final bool keepRunning;

  @override
  void onInit() {
    super.onInit();

    _storage //
        .getUserWantsToKeepRunningTheService()
        .then((keepRunning) => this.keepRunning = keepRunning == true)
        .then((_) => _backgroundService.startBackgroundService(keepRunning))
        .then((_) => _listen(true));
  }

  void _listen(bool discardNextGo) {
    _createStream(discardNextGo).take(1).firstOrNull().then((_) => connectedTrigger.trigger(null));
  }

  Stream _createStream(bool discardNextGo) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (_) async => await _nodeStatusRepository.getNodeStatus().catchError((_) => NodeStatusModel.notConnectedYet()),
    ) //
        .asyncMap((event) => event)
        .skipWhile((element) => !element.active)
        .timeout(const Duration(seconds: 10), onTimeout: (e) {
      e.close();
      if (discardNextGo) {
        connectedTrigger.trigger(null);
      } else {
        _backgroundService.startBackgroundService(true, force: true);
        _listen(true);
      }
    });
  }
}
