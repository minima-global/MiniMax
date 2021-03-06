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
    return KeyboardVisibilityBuilder(
      builder: (_, isKeyboardVisible) {
        return Scaffold(
          backgroundColor: coreBlackDarkBlack,
          body: _buildBody(isKeyboardVisible),
        );
      },
    );
  }

  Widget _buildBody(bool isKeyboardVisible) {
    return Stack(
      children: [
        ListView(
          physics: isKeyboardVisible ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
          children: [
            _buildTerminal(),
            large2.toSpace(),
            Container(
              width: double.maxFinite,
              height: 1,
              color: coreGrey100,
            ),
            medium.toSpace(),
            _buildCommandInput(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(small1),
          child: Align(
            alignment: Alignment.topRight,
            child: _buildFloatingActionButton(),
          ),
        ),
      ],
    );
  }

  Widget _buildTerminal() {
    return Container(
      padding: const EdgeInsetsDirectional.only(top: large2, start: large1, end: large1),
      height: Get.height * 0.6,
      child: const ConsolePlatformView(),
    );
  }

  Widget _buildCommandInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: large1),
      child: semiTransparentModal(
        colour: terminalInputBackground,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: large1),
                child: Text(
                  StringKeys.terminalScreenTextFieldTitle.tr,
                  style: lmH2.copyWith(color: textColourWhiteDM),
                ),
              ),
              small2.toSpace(),
              semiTransparentModal(
                colour: terminalInputBackground2,
                child: Padding(
                  padding: const EdgeInsets.all(medium),
                  child: TextFormField(
                    focusNode: _runCommandFocusNode,
                    controller: controller.runCommandController,
                    keyboardType: TextInputType.visiblePassword,
                    maxLines: 1,
                    textInputAction: TextInputAction.send,
                    style: lmH2.copyWith(color: coreGrey40),
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
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.small(
      onPressed: () {
        controller.clearConsole();
        hideKeyboard();
      },
      backgroundColor: coreBlue100,
      child: const Icon(Icons.delete_outline, color: white),
    );
  }
}
