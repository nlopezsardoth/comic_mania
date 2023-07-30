import 'package:comic_mania/domain/entities/comic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final thisMonthComicsProvider =
    StateNotifierProvider<ComicsNotifier, List<Comic>>((ref) {
  final fetchMoreComics = ref.watch(comicRepositoryProvider).getComics;

  return ComicsNotifier(fetchMoreComics: fetchMoreComics);
});

typedef ComicCallback = Future<List<Comic>> Function({int offset});

class ComicsNotifier extends StateNotifier<List<Comic>> {
  int currentOffset = 0;
  ComicCallback fetchMoreComics;

  ComicsNotifier({
    required this.fetchMoreComics,
  }) : super([]);

  Future<void> loadNextPage() async {
    currentOffset = currentOffset + 50;
    final List<Comic> comics = await fetchMoreComics(offset: currentOffset);
    state = [...state, ...comics];
  }
}
