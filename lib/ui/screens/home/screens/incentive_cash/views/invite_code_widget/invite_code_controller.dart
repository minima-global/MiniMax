import 'package:clipboard/clipboard.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/data/repositories/ping_repository.dart';

class InviteCodeController extends GetxController {
  final PingRepository _pingRepository;
  final MinimaStorage _minimaStorage;

  final Rxn<String> inviteCode = Rxn<String>();
  final Rxn copiedTrigger = Rxn();

  InviteCodeController(this._pingRepository, this._minimaStorage);

  @override
  void onInit() {
    super.onInit();
    loadInviteCode();
  }

  void copyInviteCodeToClipboard({required String textToCopy}) {
    FlutterClipboard //
            .copy(textToCopy)
        .then((_) => copiedTrigger.trigger(null));
  }

  void loadInviteCode() {
    _minimaStorage
        .getNodeId() //
        .then((uid) {
          if (uid != null) {
            return _pingRepository.getPingAndRewards(uid: uid);
          } else {
            return Future.error(Exception("No UID"));
          }
        })
        .then((value) => value.inviteCode)
        .then((inviteCode) {
          this.inviteCode(inviteCode);
        });
  }

  void shareLink({required String shareTitle, required String text}) {
    FlutterShare.share(title: shareTitle, text: text);
  }
}
