class PaginationModel {
  int? currentPage;
  int? total;

  PaginationModel({
    this.currentPage,
    this.total,
  });

  PaginationModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    total = json['last_page'];
  }

  bool get isLastPage {
    return currentPage == total;
  }
}
