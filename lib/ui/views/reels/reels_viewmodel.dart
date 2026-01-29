import 'package:stacked/stacked.dart';
import '../../../app/locator.dart';
import '../../../core/repositories/reels_repository.dart';

class ReelsViewModel extends BaseViewModel {
  final ReelsRepository _repo = locator<ReelsRepository>();

  List<String> images = [];

  Future<void> init() async {
    setBusy(true);
    try {
      images = await _repo.getReelsImages();
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> refresh() => init();

  void like(int index) {
    // TODO: лайк логика
  }

  void comment(int index) {
    // TODO: комменты
  }

  void share(int index) {
    // TODO: шаринг
  }
}
