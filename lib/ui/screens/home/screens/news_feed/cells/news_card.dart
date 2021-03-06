import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/dimensions.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/ui/screens/home/screens/news_feed/model/news_model.dart';
import 'package:minimax/ui/utils/simple_html_text.dart';

class NewsCard extends StatelessWidget {
  final NewsModel _newsModel;

  const NewsCard(this._newsModel);

  @override
  Widget build(BuildContext context) {
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
      child: simpleHtmlText(_newsModel.content),
    );
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
}
