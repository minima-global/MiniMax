class NodeStatusModel {
  final bool infoAvailable;
  final bool active;
  final bool apkUpToDate;

  NodeStatusModel.notConnectedYet()
      : active = false,
        apkUpToDate = false,
        infoAvailable = false;

  NodeStatusModel.connected({required this.apkUpToDate})
      : active = true,
        infoAvailable = true;
}
