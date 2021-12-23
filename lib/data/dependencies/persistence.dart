import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MinimaStorage {
  final FlutterSecureStorage _storage;

  MinimaStorage(this._storage);

  static const _userConfiguredDeviceFirstTimeKey = "_userConfiguredDeviceFirstTimeKey";

  Future<bool> getUserConfiguredDeviceFirstTime() =>
      _storage.read(key: _userConfiguredDeviceFirstTimeKey).then((value) => value == true.toString());

  void setUserConfiguredDeviceFirstTime(bool userConfiguredDeviceFirstTime) {
    _storage.write(key: _userConfiguredDeviceFirstTimeKey, value: userConfiguredDeviceFirstTime.toString());
  }

  static const _nodeIdSavedKey = "_nodeIdSavedKey";

  Future<String?> getNodeId() {
    return _storage.read(key: _nodeIdSavedKey);
  }

  Future setNodeId(String nodeId) {
    return _storage.write(key: _nodeIdSavedKey, value: nodeId);
  }
}
