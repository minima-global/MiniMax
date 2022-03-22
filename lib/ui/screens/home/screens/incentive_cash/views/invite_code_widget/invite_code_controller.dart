import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/data/repositories/ping_repository.dart';
import 'package:minimax/res/translations/string_keys.dart';

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

  void copyInviteCodeToClipboard() {
    FlutterClipboard //
            .copy(inviteCode.value ?? "")
        .then((_) => copiedTrigger.trigger(null));
  }

  void loadInviteCode() {
    _minimaStorage
        .getNodeId() //
        .then((uid) => _pingRepository.getPingAndRewards(uid: (uid ?? (throw Exception()))))
        .then((value) => value.inviteCode)
        .then((inviteCode) {
      this.inviteCode(inviteCode);
    });
  }

  void shareLink({required String shareTitle, required String placeholder}) {
    FlutterShare.share(title: shareTitle, text: placeholder.trArgs([inviteCode.value ?? ""]));
  }
}
