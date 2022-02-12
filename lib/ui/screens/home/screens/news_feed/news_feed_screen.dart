import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/ui/screens/home/screens/news_feed/cells/news_card.dart';
import 'package:minimax/ui/screens/home/screens/news_feed/model/news_model.dart';
import 'package:minimax/ui/screens/home/screens/news_feed/news_feed_controller.dart';
import 'package:minimax/ui/utils/errors.dart';
import 'package:minimax/ui/utils/separated_column.dart';
import 'package:minimax/utils/extensions/rx_extensions.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';

class NewsFeedScreen extends GetWidget<NewsFeedController> {
  static const String routeName = "/home/news_feed";

  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.error.listenWhenNotNull((_) => showError());

    return Scaffold(
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return controller.loading.buildOnBuildChange(
      onTrue: _buildLoader,
      onFalse: _buildNews,
    );
  }

  Widget _buildLoader() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }

  Widget _buildNews() {
    return controller.news.build((news) {
      List<Widget> newsCards = news //
          .map(_buildNewsCard)
          .toList();

      return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: [
          CupertinoSliverRefreshControl(onRefresh: () {
            controller.loadNews(isRefreshing: true);
            return HapticFeedback.mediumImpact();
          }),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SeparatedColumn.withSeparation(children: newsCards, separator: medium.toSpace()),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildNewsCard(NewsModel newsModel) {
    return NewsCard(newsModel);
  }
}
