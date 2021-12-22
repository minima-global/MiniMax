import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/translations/string_keys.dart';

void showError({String? message, String? title}) {
  Get.snackbar(
    title ?? StringKeys.generalNetworkTitleError.tr,
    message ?? StringKeys.generalNetworkTitleError.tr,
    colorText: white,
    backgroundColor: signsWarning,
  );
}
