import 'package:stacked/stacked.dart';
import '../../../app/locator.dart';
import '../../../core/models/message_thread.dart';
import '../../../core/repositories/direct_repository.dart';

class DirectViewModel extends BaseViewModel {
  final DirectRepository _repo = locator<DirectRepository>();

  List<MessageThread> threads = [];

  Future<void> init() async {
    setBusy(true);
    try {
      threads = await _repo.getThreads();
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> refresh() => init();

  void onCompose() {
    // TODO: создать новый чат
  }

  void openThread(MessageThread thread) {
    // TODO: навигация в чат
  }
}
