import 'package:minimax/data/dependencies/network_manager.dart';
import 'package:dart_rss/dart_rss.dart';

abstract class PingService {
  Future<RssFeed> getNews({required String uid});
}

class PingServiceImpl extends PingService {
  final DioClient _dioClient;

  PingServiceImpl(this._dioClient);

  @override
  Future<RssFeed> getNews({required String uid}) {
    return _dioClient.dio
        .get("api/ping/$uid")
        .then((value) => RssFeed.parse(value.data as String));
  }
}
