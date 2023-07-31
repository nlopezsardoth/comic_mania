import 'package:comic_mania/presentation/providers/comics/comics_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/comic.dart';

final comicInfoProvider =
    StateNotifierProvider<ComicMapNotifier, Map<String, Comic>>((ref) {
  final comicRepository = ref.watch(comicRepositoryProvider);
  return ComicMapNotifier(getComic: comicRepository.getComicById);
});

typedef GetComicCallback = Future<Comic?> Function(String comicId);

class ComicMapNotifier extends StateNotifier<Map<String, Comic>> {
  final GetComicCallback getComic;

  ComicMapNotifier({
    required this.getComic,
  }) : super({});

  Future<void> loadComic(String comicId) async {
    if (state[comicId] != null) return;
    final comic = await getComic(comicId);
    state = {...state, comicId: comic!};
  }
}
