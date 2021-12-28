class PDFPageIndicatorModel {
  int currentPage;
  final int totalPages;

  PDFPageIndicatorModel({required this.currentPage, required this.totalPages});

  void changeCurrentPage(int newCurrentPage) {
    currentPage = newCurrentPage + 1;
  }

  PDFPageIndicatorModel.initialWithTotalCount(int totalCount)
      : currentPage = _initialPage,
        totalPages = totalCount;

  static const int _initialPage = 1;
}