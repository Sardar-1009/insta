import 'package:get_it/get_it.dart';

import '../core/services/feed_service.dart';
import '../core/repositories/feed_repository.dart';

import '../core/services/direct_service.dart';
import '../core/services/search_service.dart';
import '../core/services/reels_service.dart';
import '../core/services/profile_service.dart';

import '../core/repositories/direct_repository.dart';
import '../core/repositories/search_repository.dart';
import '../core/repositories/reels_repository.dart';
import '../core/repositories/profile_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  // services
  locator.registerLazySingleton<FeedService>(() => FeedService());
  locator.registerLazySingleton<DirectService>(() => DirectService());
  locator.registerLazySingleton<SearchService>(() => SearchService());
  locator.registerLazySingleton<ReelsService>(() => ReelsService());
  locator.registerLazySingleton<ProfileService>(() => ProfileService());

  // repositories
  locator.registerLazySingleton<FeedRepository>(() => FeedRepository(locator()));
  locator.registerLazySingleton<DirectRepository>(() => DirectRepository(locator()));
  locator.registerLazySingleton<SearchRepository>(() => SearchRepository(locator()));
  locator.registerLazySingleton<ReelsRepository>(() => ReelsRepository(locator()));
  locator.registerLazySingleton<ProfileRepository>(() => ProfileRepository(locator()));
}
