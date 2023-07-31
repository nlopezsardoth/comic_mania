import 'package:comic_mania/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(thisWeekComicsProvider.notifier).loadNextPage();
    ref.read(lastWeekComicsProvider.notifier).loadNextPage();
    ref.read(nextWeekComicsProvider.notifier).loadNextPage();
    ref.read(thisMonthComicsProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final slideShowComics = ref.watch(comicsSlideshowProvider);
    final thisWeekComics = ref.watch(thisWeekComicsProvider);
    final lastWeekComics = ref.watch(lastWeekComicsProvider);
    final nextWeekComics = ref.watch(nextWeekComicsProvider);
    final thisMonthComics = ref.watch(thisMonthComicsProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            ComicsSlideshow(comics: slideShowComics),
            ComicHorizontalListview(
                comics: thisWeekComics,
                title: 'This week',
                loadNextPage: () =>
                    ref.read(thisWeekComicsProvider.notifier).loadNextPage()),
            ComicHorizontalListview(
                comics: lastWeekComics,
                title: 'Last week',
                loadNextPage: () =>
                    ref.read(lastWeekComicsProvider.notifier).loadNextPage()),
            ComicHorizontalListview(
                comics: nextWeekComics,
                title: 'Next week',
                loadNextPage: () =>
                    ref.read(nextWeekComicsProvider.notifier).loadNextPage()),
            ComicHorizontalListview(
                comics: thisMonthComics,
                title: 'This month',
                loadNextPage: () =>
                    ref.read(thisMonthComicsProvider.notifier).loadNextPage()),
            const SizedBox(height: 10),
          ],
        );
      }, childCount: 1)),
    ]);
  }
}
