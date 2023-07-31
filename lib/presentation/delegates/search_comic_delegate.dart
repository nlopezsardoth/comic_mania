import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import '../../domain/entities/comic.dart';

typedef SearchComicsCallback = Future<List<Comic>> Function(String query);

class SearchComicDelegate extends SearchDelegate<Comic?> {
  final SearchComicsCallback searchComics;
  List<Comic> initialComics;

  StreamController<List<Comic>> debouncedComics = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchComicDelegate({
    required this.searchComics,
    required this.initialComics,
  }) : super(
          searchFieldLabel: 'Buscar películas',
          // textInputAction: TextInputAction.done
        );

  void clearStreams() {
    debouncedComics.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final comics = await searchComics(query);
      initialComics = comics;
      debouncedComics.add(comics);
      isLoadingStream.add(false);
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialComics,
      stream: debouncedComics.stream,
      builder: (context, snapshot) {
        final comics = snapshot.data ?? [];

        return ListView.builder(
          itemCount: comics.length,
          itemBuilder: (context, index) => _ComicItem(
            comic: comics[index],
            onComicSelected: (context, comic) {
              clearStreams();
              close(context, comic);
            },
          ),
        );
      },
    );
  }

  // @override
  // String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_rounded)),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
                onPressed: () => query = '', icon: const Icon(Icons.clear)),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}

class _ComicItem extends StatelessWidget {
  final Comic comic;
  final Function onComicSelected;

  const _ComicItem({required this.comic, required this.onComicSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onComicSelected(context, comic);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  comic.thumbNailPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comic.title, style: textStyles.titleMedium),
                  Row(
                    children: [
                      Icon(Icons.label, color: colors.primary),
                      const SizedBox(width: 3),
                      Text('Pages: ${comic.pageCount}',
                          style: textStyles.bodyMedium
                              ?.copyWith(color: colors.primary))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
