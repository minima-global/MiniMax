import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:minimax/ui/screens/pdf_screen/model/pdf_model.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';
import 'package:get/get.dart';

class PDFController extends GetxController {
  final Rxn<PDFDocument> pdfDocument = Rxn();
  final Rxn<PDFPageIndicatorModel> pageIndicatorModel = Rxn();
  final Rxn error = Rxn();

  void listenToEvents({
    required Function onError,
  }) {
    error.listenWhenNotNull((_) => onError);
  }

  void loadPdfDocument(Future<PDFDocument> pdfDocument) {
    pdfDocument //
        .then((pdfDocument) {
      this.pdfDocument.call(pdfDocument);
      pageIndicatorModel.call(PDFPageIndicatorModel.initialWithTotalCount(pdfDocument.count));
    });
  }

  void pageChanged(int newCurrentPage) {
    pageIndicatorModel.trigger(pageIndicatorModel.value?..changeCurrentPage(newCurrentPage));
  }
}
