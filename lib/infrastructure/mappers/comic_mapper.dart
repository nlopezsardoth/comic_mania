import 'package:comic_mania/domain/entities/comic.dart';
import 'package:comic_mania/infrastructure/models/marvel/comic_marvel.dart';

class ComicMapper {
  Comic marvelComicToEntity(ComicMarvel comicMarvel) => Comic(
        id: comicMarvel.id,
        title: comicMarvel.title,
        issueNumber: comicMarvel.issueNumber,
        pageCount: comicMarvel.pageCount,
        thumbNailPath:
            "${comicMarvel.thumbnail.path}.${comicMarvel.thumbnail.extension}",
        creators: List<Creator>.from(
          comicMarvel.creators.items.map((creator) => Creator(
              name: creator.name ?? "",
              role: roleValues.map[creator.role] ?? Role.letterer)),
        ),
      );

  final roleValues = EnumValues({
    "colorist": Role.colorist,
    "editor": Role.editor,
    "inker": Role.inker,
    "letterer": Role.letterer,
    "penciler": Role.penciler,
    "penciler (cover)": Role.penilerCover,
    "penciller": Role.penciller,
    "writer": Role.writer
  });
}