import '../models/message_thread.dart';
import '../services/direct_service.dart';

class DirectRepository {
  final DirectService _service;
  DirectRepository(this._service);

  Future<List<MessageThread>> getThreads() => _service.fetchThreads();
}
