import 'dart:convert';

import 'package:minimax/data/dependencies/background.dart';
import 'package:minimax/ui/screens/home/screens/node_status/model/node_status_model.dart';
import 'package:minimax/ui/utils/errors.dart';
import 'package:minimax/utils/extensions/object_extensions.dart';
import 'package:package_info/package_info.dart';

// TODO test this class
abstract class NodeStatusRepository {
  Future<NodeStatusModel> getNodeStatus({bool refresh = false});
}

class NodeStatusRepositoryImpl extends NodeStatusRepository {
  final BackgroundService _backgroundService;
  final PackageInfo _packageInfo;

  NodeStatusRepositoryImpl(this._backgroundService, this._packageInfo);

  @override
  Future<NodeStatusModel> getNodeStatus({bool refresh = false}) {
    Future<NodeStatusModel> future = _backgroundService.getNodeStatus().then((value) {
      if (value == null) {
        return NodeStatusModel.notConnectedYet();
      } else {
        Map<String, dynamic> json = jsonDecode(value);
        bool connected = (cast<int>(json["response"]?["network"]?["connected"]) ?? 0) > 0;
        if (connected) {
          return NodeStatusModel.connected(
            apkUpToDate: (json["response"]["version"] as String).compareToCurrentVersion(_packageInfo) >= 0,
          );
        } else {
          return NodeStatusModel.notConnectedYet();
        }
      }
    });
    if (!refresh) {
      return future;
    } else {
      return future
          .retryOnMinimaNotStarted(getNodeStatus);
    }
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
