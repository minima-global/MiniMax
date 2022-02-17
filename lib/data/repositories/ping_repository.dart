import 'package:minimax/data/services/news_service.dart';
import 'package:minimax/data/services/ping/ping_response_model.dart';
import 'package:minimax/data/services/ping/ping_service.dart';
import 'package:minimax/ui/screens/home/screens/news_feed/model/news_model.dart';
import 'package:minimax/utils/extensions/iterable_extensions.dart';

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
