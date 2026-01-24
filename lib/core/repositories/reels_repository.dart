import '../services/reels_service.dart';

class ReelsRepository {
  final ReelsService _service;
  ReelsRepository(this._service);

  Future<List<String>> getReelsImages() => _service.fetchReelsImages();
}
