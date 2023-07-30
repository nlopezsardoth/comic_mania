import '../entities/comic.dart';

abstract class ComicsDatasource {
  Future<List<Comic>> getComics({int offset = 0});
}
