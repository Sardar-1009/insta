import '../services/search_service.dart';

class SearchRepository {
  final SearchService _service;
  SearchRepository(this._service);

  Future<List<String>> searchImages(String query) {
    return _service.fetchImageUrls(query: query);
  }
}
