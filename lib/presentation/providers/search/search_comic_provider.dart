import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/comic.dart';
import '../providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedComicsProvider =
    StateNotifierProvider<SearchedComicsNotifier, List<Comic>>((ref) {
  final comicRepository = ref.read(comicRepositoryProvider);

  return SearchedComicsNotifier(
      searchComics: comicRepository.searchComics, ref: ref);
});

typedef SearchComicsCallback = Future<List<Comic>> Function(String query);

class SearchedComicsNotifier extends StateNotifier<List<Comic>> {
  final SearchComicsCallback searchComics;
  final Ref ref;

  SearchedComicsNotifier({
    required this.searchComics,
    required this.ref,
  }) : super([]);

  Future<List<Comic>> searchComicsByQuery(String query) async {
    final List<Comic> comics = await searchComics(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = comics;
    return comics;
  }
}
