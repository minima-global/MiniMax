import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:minimax/data/dependencies/background.dart';
import 'package:minimax/ui/screens/home/screens/node_status/model/node_status_model.dart';
import 'package:package_info/package_info.dart';

// TODO test this class
abstract class NodeStatusRepository {
  Future<NodeStatusModel> getNodeStatus();
}

class NodeStatusRepositoryImpl extends NodeStatusRepository {
  final BackgroundService _backgroundService;
  final PackageInfo _packageInfo;

  NodeStatusRepositoryImpl(this._backgroundService, this._packageInfo);

  int timeoutMilliseconds = 500;
  @override
  Future<NodeStatusModel> getNodeStatus({int timeout = 500}) {
    return _backgroundService.getNodeStatus().then((value) {
      if (value == null) {
        return NodeStatusModel.notConnectedYet();
      } else {
        dynamic json = jsonDecode(value);
        bool status = json["status"] as bool;
        if (status) {
          return NodeStatusModel.connected(
            apkUpToDate: (json["response"]["version"] as String).compareToCurrentVersion(_packageInfo) >= 0,
          );
        } else {
          return NodeStatusModel.notConnectedYet();
        }
      }
    }).timeout(Duration(milliseconds: timeoutMilliseconds), onTimeout: () {
      return getNodeStatus(timeout: timeout + 500);
    }).catchError((error) {
      if (error is PlatformException && error.code == "MINIMA_NOT_STARTED") {
        return getNodeStatus(timeout: timeout + 500);
      }
    });
  }
}

extension VersionComparationExtension on String {
  int compareToCurrentVersion(PackageInfo _packageInfo) {
    int versionLength = 3;
    try {
      List<int> splitVersion = split(".").map((e) => int.parse(e)).toList();
      List<int> packageVersion = _packageInfo.version.split(".").map((e) => int.parse(e)).toList();
      if (splitVersion.length != versionLength || packageVersion.length != versionLength) {
        return -1;
      }

      for (int i = 0; i < versionLength; i++) {
        int comparison = packageVersion[i].compareTo(splitVersion[i]);
        if (comparison != 0) {
          return comparison;
        }
      }

      return 0;
    } on FormatException {
      return -1;
    }
  }
}
