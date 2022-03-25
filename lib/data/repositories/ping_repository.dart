import 'package:minimax/data/services/ping/ping_response_model.dart';
import 'package:minimax/data/services/ping/ping_service.dart';

abstract class PingRepository {
  Future<PingResponseModel> getPingAndRewards({required String uid});
}

class PingRepositoryImpl extends PingRepository {
  final PingService _service;

  PingRepositoryImpl(this._service);

  @override
  Future<PingResponseModel> getPingAndRewards({required String uid}) {
    return _service.getPingAndRewards(uid: uid);
  }
}
