import 'package:comic_mania/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/comic.dart';
import '../../delegates/search_comic_delegate.dart';
import '../../providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(Icons.import_contacts, color: colors.primary),
                const SizedBox(width: 5),
                Text('Comic Mania', style: titleStyle),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      final searchedComics = ref.read(searchedComicsProvider);
                      final searchQuery = ref.read(searchQueryProvider);

                      showSearch<Comic?>(
                              query: searchQuery,
                              context: context,
                              delegate: SearchComicDelegate(
                                  initialComics: searchedComics,
                                  searchComics: ref
                                      .read(searchedComicsProvider.notifier)
                                      .searchComicsByQuery))
                          .then((comic) {
                        if (comic == null) return;

                        appRouter.push('/comic/${comic.id}');
                      });
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
        ));
  }
}
