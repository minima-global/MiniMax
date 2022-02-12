import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InviteCodeController extends GetxController {
  final TextEditingController inviteCodeController = TextEditingController();
  final Rxn<String> inviteCode = Rxn<String>();
  final Rxn copiedTrigger = Rxn();

  @override
  void onInit() {
    super.onInit();
    loadInviteCode();
  }

  void copyInviteCodeToClipboard(String textToCopy) {
    FlutterClipboard //
            .copy(textToCopy)
        .then((_) => copiedTrigger.trigger(null));
  }

  void loadInviteCode() {
    String inviteCode = "TODO";
    this.inviteCode(inviteCode);
    inviteCodeController.text = inviteCode;
  }
}
