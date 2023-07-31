import 'package:comic_mania/domain/entities/comic.dart';
import 'package:comic_mania/infrastructure/models/marvel/comic_marvel.dart';

class ComicMapper {
  Comic marvelComicToEntity(ComicMarvel comicMarvel) => Comic(
      id: comicMarvel.id,
      title: comicMarvel.title,
      issueNumber: comicMarvel.issueNumber,
      pageCount: comicMarvel.pageCount,
      description: comicMarvel.textObjects.isNotEmpty
          ? comicMarvel.textObjects[0].text
          : comicMarvel.description ?? "",
      thumbNailPath:
          "${comicMarvel.thumbnail.path}.${comicMarvel.thumbnail.extension}"
              .replaceAll("http", "https"),
      creators: List<Creator>.from(
        comicMarvel.creators.items.map((creator) => Creator(
            name: creator.name ?? "",
            role: roleValues.map[creator.role] ?? Role.letterer)),
      ),
      price: comicMarvel.prices[0].price.toString());

  final roleValues = EnumValues({
    "colorist": Role.colorist,
    "editor": Role.editor,
    "inker": Role.inker,
    "letterer": Role.letterer,
    "penciller": Role.penciler,
    "penciler": Role.penciler,
    "penciller (cover)": Role.pencilerCover,
    "penciler (cover)": Role.pencilerCover,
    "writer": Role.writer
  });
}
