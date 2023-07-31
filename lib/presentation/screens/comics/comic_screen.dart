import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import '../../../domain/entities/comic.dart';
import '../../providers/providers.dart';

class ComicScreen extends ConsumerStatefulWidget {
  static const name = 'comic-screen';

  final String comicId;

  const ComicScreen({super.key, required this.comicId});

  @override
  ComicScreenState createState() => ComicScreenState();
}

class ComicScreenState extends ConsumerState<ComicScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(comicInfoProvider.notifier).loadComic(widget.comicId);
  }

  @override
  Widget build(BuildContext context) {
    final Comic? comic = ref.watch(comicInfoProvider)[widget.comicId];

    if (comic == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(comic: comic),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _ComicDetails(comic: comic),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _ComicDetails extends StatelessWidget {
  final Comic comic;

  const _ComicDetails({required this.comic});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(comic.title, style: textStyles.titleLarge),
          const SizedBox(height: 10),
          // Image
          Align(
            alignment: Alignment.center,
            child: Image.network(
              comic.thumbNailPath,
              width: size.width * 0.8,
              height: size.height * 0.7,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: 20),

          _CreatorsWidget(
            comic: comic,
            role: Role.writer,
            title: "Writer",
          ),
          _CreatorsWidget(
            comic: comic,
            role: Role.penciler,
            title: "Peniler",
          ),
          _CreatorsWidget(
            comic: comic,
            role: Role.pencilerCover,
            title: "Cover Artist",
          ),
          _CreatorsWidget(
            comic: comic,
            role: Role.editor,
            title: "Editor",
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class _CreatorsWidget extends StatelessWidget {
  const _CreatorsWidget({
    required this.comic,
    required this.role,
    required this.title,
  });

  final Comic comic;
  final Role role;
  final String title;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final List<Creator> creators =
        comic.creators.where((creator) => creator.role == role).toList();
    return creators.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textStyles.titleMedium,
              ),
              Text(creators.map((creator) => creator.name).toList().join(' ,')),
              const SizedBox(
                height: 10,
              )
            ],
          );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Comic comic;

  const _CustomSliverAppBar({required this.comic});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.2,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                comic.thumbNailPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.7, 1.0],
                          colors: [Colors.transparent, Colors.black87]))),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topLeft, stops: [
                0.0,
                0.3
              ], colors: [
                Colors.black87,
                Colors.transparent,
              ]))),
            ),
          ],
        ),
      ),
    );
  }
}
