import 'package:comic_mania/domain/entities/comic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final thisWeekComicsProvider =
    StateNotifierProvider<ComicsNotifier, List<Comic>>((ref) {
  final fetchMoreComics = ref.watch(comicRepositoryProvider).getThisWeekComics;

  return ComicsNotifier(fetchMoreComics: fetchMoreComics);
});

final lastWeekComicsProvider =
    StateNotifierProvider<ComicsNotifier, List<Comic>>((ref) {
  final fetchMoreComics = ref.watch(comicRepositoryProvider).getLastWeekComics;

  return ComicsNotifier(fetchMoreComics: fetchMoreComics);
});

final nextWeekComicsProvider =
    StateNotifierProvider<ComicsNotifier, List<Comic>>((ref) {
  final fetchMoreComics = ref.watch(comicRepositoryProvider).getNextWeekComics;

  return ComicsNotifier(fetchMoreComics: fetchMoreComics);
});

final thisMonthComicsProvider =
    StateNotifierProvider<ComicsNotifier, List<Comic>>((ref) {
  final fetchMoreComics = ref.watch(comicRepositoryProvider).getThisMonthComics;

  return ComicsNotifier(fetchMoreComics: fetchMoreComics);
});

typedef ComicCallback = Future<List<Comic>> Function({int offset});

class ComicsNotifier extends StateNotifier<List<Comic>> {
  int currentOffset = -20;
  bool isLoading = false;
  ComicCallback fetchMoreComics;

  ComicsNotifier({
    required this.fetchMoreComics,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;

    currentOffset = currentOffset + 20;
    final List<Comic> comics = await fetchMoreComics(offset: currentOffset);
    state = [...state, ...comics];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
