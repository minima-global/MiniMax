import 'package:get/get.dart';
import 'package:minimax/data/repositories/news_repository.dart';
import 'package:minimax/ui/screens/home/screens/news_feed/model/news_model.dart';

class NewsFeedController extends GetxController {
  final NewsRepository _newsRepository;

  NewsFeedController(this._newsRepository);

  final RxList<NewsModel> news = RxList();
  final Rxn error = Rxn();
  final RxBool loading = RxBool(false);

  @override
  void onInit() {
    super.onInit();

    loadNews(isRefreshing: false);
  }

  Future<void> loadNews({required bool isRefreshing}) {
    if (!isRefreshing) {
      loading(true);
    }

    _newsRepository
        .getNews()
        .then((news) => this.news(news))
        .catchError((error) => this.error.trigger(error))
        .whenComplete(() => loading(false));

    return Future.value();
  }
}
