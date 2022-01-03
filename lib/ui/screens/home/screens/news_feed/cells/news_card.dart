import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/dimensions.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/ui/screens/home/screens/news_feed/model/news_model.dart';
import 'package:minimax/utils/extensions/object_extensions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';

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
      child: Image.network(
        _newsModel.thumbnail,
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
      child: Html(
        data: _newsModel.content,
        onLinkTap: (String? url, _, __, ___) => url?.let((url) => launch(url)),
        tagsList: Html.tags..removeWhere((element) => ["img", "figure"].contains(element)),
        style: {
          "body": Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
          "html": Style.fromTextStyle(lmBodyCopyMedium.copyWith(color: coreBlackContrast)),
        },
      ),
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
