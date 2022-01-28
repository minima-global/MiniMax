import 'package:minimax/data/dependencies/network_manager.dart';
import 'package:dart_rss/dart_rss.dart';

abstract class NewsService {
  Future<RssFeed> getNews();
}

class NewsServiceImpl extends NewsService {
  final DioClient _dioClient;

  NewsServiceImpl(this._dioClient);

  @override
  Future<RssFeed> getNews() {
    return _dioClient.dio
        .get("https://medium.com/feed/minimacommunity")
        .then((value) => RssFeed.parse(value.data as String));
  }
}
