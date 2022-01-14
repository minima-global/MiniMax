import 'package:flutter/services.dart';
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

const int _retryTimeoutMilliseconds = 500;
extension ErrorFutureExtensions<T> on Future<T> {
  Future<T> retryOnMinimaNotStarted(Future<T> Function() creator) {
    return timeout(const Duration(milliseconds: _retryTimeoutMilliseconds), onTimeout: () {
      return creator();
    }).catchError((error) {
      if (error is PlatformException && error.code == "MINIMA_NOT_STARTED") {
        return creator();
      }
    });
  }
}
