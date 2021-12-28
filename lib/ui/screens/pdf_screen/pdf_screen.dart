import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/pdf_screen/pdf_controller.dart';
import 'package:minimax/ui/utils/errors.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';
import 'package:sprintf/sprintf.dart';

class PDFScreen extends GetWidget<PDFController> {
  final Future<PDFDocument> futurePDFDocument;
  final String title;

  PDFScreen.fromUrl({
    Key? key,
    required String url,
    required this.title,
    bool useAuthHeaders = false,
  })  : futurePDFDocument = PDFDocument.fromURL(url),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.loadPdfDocument(futurePDFDocument);
    controller.listenToEvents(onError: onError);

    return Scaffold(
      body: _buildBody(),
      appBar: _buildAppBar(),
      backgroundColor: white,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: white,
      // Make an action as end padding
      actions: [Container(width: large2)],
      leading: IconButton(onPressed: Get.back, icon: const Icon(Icons.arrow_back), color: coreBlackContrast),
      title: AutoSizeText(
        title,
        maxLines: 1,
        minFontSize: 0,
        style: lmH2.copyWith(color: coreBlackContrast),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildPageIndicator(),
        Expanded(child: _buildPDFViewer()),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      color: coreGrey5,
      height: 56,
      child: controller.pageIndicatorModel.buildIgnoreNull(
        (pageIndicator) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCurrentPageIndicator(pageIndicator.currentPage),
            small1.toSpace(),
            _buildAllPagesIndicator(pageIndicator.totalPages),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPageIndicator(int currentPage) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        width: 40,
        height: 40,
        color: white,
        child: Center(
          child: Text(
            currentPage.toString(),
            style: lmH4.copyWith(color: coreBlackContrast),
          ),
        ),
      ),
    );
  }

  Widget _buildAllPagesIndicator(int totalPages) {
    return Text(
      sprintf(StringKeys.pdfReaderPagesOfD.tr, [totalPages]),
      style: lmBodyCopy.copyWith(color: coreGrey100),
    );
  }

  Widget _buildPDFViewer() {
    return controller.pdfDocument.buildIgnoreNull(
      (pdfDocument) {
        return PDFViewer(
          document: pdfDocument,
          scrollDirection: Axis.vertical,
          showNavigation: false,
          showIndicator: false,
          showPicker: false,
          controller: PageController(viewportFraction: 0.85),
          onPageChanged: controller.pageChanged,
        );
      },
      defaultIfNull: const Center(child: CircularProgressIndicator()),
    );
  }

  void onError() {
    showError(
      message: StringKeys.pdfReaderCantLoadPdfError.tr,
    );
  }
}
