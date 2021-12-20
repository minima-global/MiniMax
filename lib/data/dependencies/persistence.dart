import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MinimaStorage {
  final FlutterSecureStorage _storage;

  MinimaStorage(this._storage);

  static const _userConfiguredDeviceFirstTime = "_userConfiguredDeviceFirstTime";

  Future<bool> get userConfiguredDeviceFirstTime =>
      _storage.read(key: _userConfiguredDeviceFirstTime).then((value) => value == true.toString());

  set userConfiguredDeviceFirstTime(Future<bool> userConfiguredDeviceFirstTime) {
    userConfiguredDeviceFirstTime.then(
      (value) => _storage.write(key: _userConfiguredDeviceFirstTime, value: value.toString()),
    );
  }
}
