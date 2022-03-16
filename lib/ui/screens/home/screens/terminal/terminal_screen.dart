import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minimax/data/dependencies/console.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/terminal/terminal_controller.dart';
import 'package:minimax/ui/utils/simple_html_text.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';
import 'package:minimax/utils/keyboard.dart';

class TerminalScreen extends GetWidget<TerminalController> {
  static const String routeName = "/home/terminal";

  TerminalScreen({Key? key}) : super(key: key);

  final FocusNode _runCommandFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

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
    return controller.userHasSeenTerminalWarningAlready.buildIgnoreNull(
      (userHasSeenTerminalWarningAlready) =>
          userHasSeenTerminalWarningAlready ? _buildMainTerminal(isKeyboardVisible) : _buildWarningCopyPasteTerminal(),
    );
  }

  Widget _buildWarningCopyPasteTerminal() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: large2, horizontal: large1),
      child: semiTransparentModal(
        colour: terminalInputBackground2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: large1, horizontal: medium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              simpleHtmlText(
                StringKeys.terminalScreenWarning.tr,
                overridingStyles: (styles) => styles
                  ..addEntries(
                    [
                      MapEntry("html", Style.fromTextStyle(lmBodyCopyMedium.copyWith(color: coreGrey20))),
                      MapEntry("b", Style.fromTextStyle(lmH4.copyWith(color: coreGrey20))),
                    ],
                  ),
              ),
              large2.toSpace(),
              createPrimaryCTA(
                  text: StringKeys.terminalScreenContinueWarningCTA.tr, onTap: controller.warningUnderstood),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainTerminal(bool isKeyboardVisible) {
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
      height: Get.height * 0.69,
      child: _buildConsole(),
    );
  }

  Widget _buildConsole() {
    return StreamBuilder(
        stream: MinimaConsole.streamReceiver,
        builder: (_, __) {
          Future.delayed(Duration.zero).then(
            (value) => _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
          );
          return Scrollbar(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: MinimaConsole.messages
                    .map(
                      (e) => SelectableText(
                        e,
                        style: mono.copyWith(color: white),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        });
  }

  Widget _buildCommandInput() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(medium),
      child: semiTransparentModal(
        colour: terminalInputBackground2,
        child: Padding(
          padding: const EdgeInsets.all(medium),
          child: Row(
            children: [
              Expanded(
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
              small2.toSpace(),
              InkWell(
                onTap: () => hideKeyboard().then((_) => controller.runCommand()),
                child: SvgPicture.asset(
                  ImageKeys.icTerminalSend,
                  width: 32,
                  height: 32,
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
