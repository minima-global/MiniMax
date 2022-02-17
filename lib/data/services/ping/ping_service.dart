import 'package:minimax/data/dependencies/network_manager.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:minimax/data/services/ping/ping_response_model.dart';

abstract class PingService {
  Future<PingResponseModel> getPingAndRewards({required String uid});
}

class PingServiceImpl extends PingService {
  final DioClient _dioClient;

  PingServiceImpl(this._dioClient);

  @override
  Future<PingResponseModel> getPingAndRewards({required String uid}) {
    return _dioClient.dio
        .get("/api/ping/$uid")
        .then((value) => PingResponseModel.fromJson(value.data));
  }
}
