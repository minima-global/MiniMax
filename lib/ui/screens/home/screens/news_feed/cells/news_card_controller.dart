import 'package:get/get.dart';
import 'package:minimax/ui/screens/home/screens/news_feed/cells/news_card.dart';

class NewsCardController extends GetxController {
  final Rxn<bool> expanded = Rxn<bool>();

  void updateContent(String content) {
    if (content.split(" ").length > NewsCard.maxWords) {
      expanded.call(false);
    }
  }

  void toggleExpanded() {
    expanded.toggle();
  }
}