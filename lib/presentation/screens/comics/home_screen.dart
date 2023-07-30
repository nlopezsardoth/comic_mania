import 'package:comic_mania/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _HomeView());
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

    ref.read(thisMonthComicsProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final thisMonthComics = ref.watch(thisMonthComicsProvider);

    return ListView.builder(
      itemCount: thisMonthComics.length,
      itemBuilder: (context, index) {
        final comic = thisMonthComics[index];
        return ListTile(
          title: Text(comic.title),
        );
      },
    );
  }
}
