import 'package:comic_mania/domain/entities/comic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final comicsSlideshowProvider = Provider<List<Comic>>((ref) {
  final thisWeekComics = ref.watch(thisWeekComicsProvider);

  if (thisWeekComics.isEmpty) return [];

  return thisWeekComics.sublist(0, 6);
});
