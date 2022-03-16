import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/dimensions.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/news_feed/cells/news_card_controller.dart';
import 'package:minimax/ui/screens/home/screens/news_feed/model/news_model.dart';
import 'package:minimax/ui/utils/simple_html_text.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';
import 'package:minimax/utils/extensions/string_extensions.dart';

class NewsCard extends GetWidget<NewsCardController> {
  final NewsModel _newsModel;

  const NewsCard(this._newsModel);

  static const int maxWords = 50;

  @override
  Widget build(BuildContext context) {
    controller.updateContent(_newsModel.content);

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(mainModalRadius)),
      child: Container(
        color: white.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: medium),
          child: Column(
            children: [
              medium.toSpace(),
              _buildImage(),
              medium.toSpace(),
              _buildTitle(),
              small2.toSpace(),
              _buildContent(),
              small2.toSpace(),
              _buildDate(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(mainModalRadius)),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          _newsModel.thumbnail,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Padding(
            padding: const EdgeInsets.all(small1),
            child: SvgPicture.asset(ImageKeys.minimaLogoSquared),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    final int titleLength = _newsModel.title.length;
    if (_newsModel.content
        .replaceAllWeirdCharacters()
        .substring(0, titleLength * 2)
        .contains(_newsModel.title.replaceAllWeirdCharacters())) {
      // What a nightmare checking if the beginning of the article has the title included.
      return Container();
    }

    _newsModel.content.substring(0, titleLength * 2).contains(RegExp(_newsModel.title, caseSensitive: false));

    return SizedBox(
      width: double.maxFinite,
      child: Text(
        _newsModel.title,
        style: lmH2.copyWith(color: coreBlackContrast),
      ),
    );
  }

  Widget _buildContent() {
    return SizedBox(
      width: double.maxFinite,
      child: controller.expanded.build(
        (expanded) => Column(
          children: [
            _buildHtmlText(expanded),
            _buildReadMoreOrLess(expanded),
          ],
        ),
      ),
    );
  }

  Widget _buildHtmlText(bool? expanded) {
    String content;
    if (expanded == false) {
      content = _newsModel.content.split(" ").take(maxWords).join(" ") + "…";
      return Container(child: simpleHtmlText(content)); // Having the same widget wouldn't change the state, lol
    } else {
      content = _newsModel.content;
      return simpleHtmlText(content);
    }
  }

  Widget _buildDate() {
    return SizedBox(
      width: double.maxFinite,
      child: AutoSizeText(
        _newsModel.content,
        maxLines: 1,
        minFontSize: 0,
        style: lmH2.copyWith(color: coreBlackContrast),
      ),
    );
  }

  Widget _buildReadMoreOrLess(bool? expanded) {
    String text;
    switch (expanded) {
      case true:
        text = StringKeys.newsCardReadLess.tr;
        break;
      case false:
        text = StringKeys.newsCardReadMore.tr;
        break;
      default:
        return Container();
    }

    return InkWell(
      onTap: controller.toggleExpanded,
      child: Padding(
        padding: const EdgeInsets.only(top: medium, bottom: small2),
        child: SizedBox(
          width: double.maxFinite,
          child: Text(
            text,
            style: lmH4.copyWith(color: coreBlue100),
          ),
        ),
      ),
    );
  }
}
