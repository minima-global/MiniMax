import 'package:minimax/data/services/news_service.dart';
import 'package:minimax/ui/screens/home/screens/news_feed/model/news_model.dart';
import 'package:minimax/utils/extensions/iterable_extensions.dart';

abstract class NewsRepository {
  Future<List<NewsModel>> getNews();
}

class NewsRepositoryImpl extends NewsRepository {
  final NewsService _service;

  NewsRepositoryImpl(this._service);

  @override
  Future<List<NewsModel>> getNews() {
    return _service.getNews().then((rssFeed) {
      return rssFeed.items
          .map(
            (e) => NewsModel(
              title: e.title ?? "",
              thumbnail: e.content?.images.firstOrNull() ?? "",
              date: e.pubDate ?? "",
              content: e.content?.value ?? "",
            ),
          )
          .toList();
    });
  }
}
