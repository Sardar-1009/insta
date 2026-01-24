import 'package:get_it/get_it.dart';
import '../core/services/feed_service.dart';
import '../core/repositories/feed_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<FeedService>(() => FeedService());
  locator.registerLazySingleton<FeedRepository>(() => FeedRepository(locator()));
}
