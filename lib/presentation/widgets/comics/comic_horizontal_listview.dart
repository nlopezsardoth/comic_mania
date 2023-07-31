import 'package:animate_do/animate_do.dart';
import 'package:comic_mania/domain/entities/comic.dart';
import 'package:flutter/material.dart';

class ComicHorizontalListview extends StatefulWidget {
  final List<Comic> comics;
  final String? title;
  final VoidCallback? loadNextPage;

  const ComicHorizontalListview({
    super.key,
    required this.comics,
    this.title,
    this.loadNextPage,
  });

  @override
  State<ComicHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<ComicHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null) _Title(title: widget.title),
          Expanded(
              child: ListView.builder(
            controller: scrollController,
            itemCount: widget.comics.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return FadeInRight(child: _Slide(comic: widget.comics[index]));
            },
          ))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Comic comic;

  const _Slide({required this.comic});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Imagen
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                comic.thumbNailPath,
                fit: BoxFit.fill,
                height: 220,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          const SizedBox(height: 5),

          //* Title
          SizedBox(
            width: 150,
            child: Text(
              comic.title,
              maxLines: 2,
              style: textStyles.titleSmall,
            ),
          ),

          //* Pages
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.label, color: colors.primary),
                const SizedBox(width: 3),
                Text('Pages: ${comic.pageCount}',
                    style:
                        textStyles.bodyMedium?.copyWith(color: colors.primary)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;

  const _Title({this.title});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
        ],
      ),
    );
  }
}
