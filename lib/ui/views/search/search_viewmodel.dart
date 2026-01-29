import 'dart:async';
import 'package:stacked/stacked.dart';
import '../../../app/locator.dart';
import '../../../core/repositories/search_repository.dart';

class SearchViewModel extends BaseViewModel {
  final SearchRepository _repo = locator<SearchRepository>();

  List<String> images = [];
  String query = '';
  Timer? _debounce;

  Future<void> init() async {
    await runSearch('');
  }

  void setQuery(String value) {
    query = value;

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      runSearch(query);
    });

    notifyListeners();
  }

  Future<void> runSearch(String q) async {
    setBusy(true);
    try {
      images = await _repo.searchImages(q);
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  void openImage(String url) {
    // TODO: открыть detail страницу
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
