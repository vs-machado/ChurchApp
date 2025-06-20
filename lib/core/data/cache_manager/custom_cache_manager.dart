import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static CacheManager instance = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 30),
      maxNrOfCacheObjects: 200,
      repo: JsonCacheInfoRepository(databaseName: 'customCache'),
      fileService: HttpFileService(),
    ),
  );
}
