import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/platform_views/console_platform_view.dart';
import 'package:minimax/ui/screens/home/screens/terminal/terminal_controller.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/utils/keyboard.dart';

class TerminalScreen extends GetWidget<TerminalController> {
  static const String routeName = "/home/terminal";

  TerminalScreen({Key? key}) : super(key: key);

  final FocusNode _runCommandFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return withGlossyBackground(
      body: KeyboardVisibilityBuilder(
        builder: (_, isKeyboardVisible) {
          return Scaffold(
            body: _buildBody(isKeyboardVisible),
            floatingActionButton: _buildFloatingActionButton(isKeyboardVisible),
          );
        },
      ),
    );
  }

  Widget _buildBody(bool isKeyboardVisible) {
    return ListView(
      physics: isKeyboardVisible ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: large1),
      children: [
        _buildTerminal(),
        medium.toSpace(),
        _buildCommandInput(),
      ],
    );
  }

  Widget _buildTerminal() {
    return Container(
      padding: const EdgeInsetsDirectional.only(top: large2),
      height: Get.height * 0.6,
      child: semiTransparentModal(
        child: const Padding(
          padding: EdgeInsets.all(medium),
          child: ConsolePlatformView(),
        ),
      ),
    );
  }

  Widget _buildCommandInput() {
    return semiTransparentModal(
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: large1),
              child: Text(
                StringKeys.terminalScreenTextFieldTitle.tr,
                style: lmH2.copyWith(color: coreBlackContrast),
              ),
            ),
            small2.toSpace(),
            semiTransparentModal(
              child: Padding(
                padding: const EdgeInsets.all(medium),
                child: TextFormField(
                  focusNode: _runCommandFocusNode,
                  controller: controller.runCommandController,
                  keyboardType: TextInputType.visiblePassword,
                  maxLines: 1,
                  textInputAction: TextInputAction.send,
                  style: lmH2.copyWith(color: coreBlackContrast),
                  onEditingComplete: controller.runCommand,
                  decoration: InputDecoration.collapsed(
                    hintText: StringKeys.terminalScreenTextFieldHint.tr,
                    hintStyle: lmH2.copyWith(color: coreGrey40),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(bool isKeyboardVisible) {
    return Visibility(
      visible: !isKeyboardVisible,
      child: FloatingActionButton.extended(
        onPressed: () {
          controller.clearConsole();
          hideKeyboard();
        },
        label: Text(
          StringKeys.terminalScreenClearConsole.tr,
        ),
      ),
    );
  }
}
