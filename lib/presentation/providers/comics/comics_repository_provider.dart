import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:comic_mania/infrastructure/datasources/marvel_comic_datasource_impl.dart';
import 'package:comic_mania/infrastructure/repositories/comic_repository_impl.dart';

final comicRepositoryProvider = Provider((ref) {
  return ComicRepositoryImpl(MarvelComicsDatasource());
});
