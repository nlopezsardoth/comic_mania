import '../entities/comic.dart';

abstract class ComicsDatasource {
  Future<List<Comic>> getAllComics({int offset = 0});
  Future<List<Comic>> getThisWeekComics({int offset = 0});
  Future<List<Comic>> getLastWeekComics({int offset = 0});
  Future<List<Comic>> getNextWeekComics({int offset = 0});
  Future<List<Comic>> getThisMonthComics({int offset = 0});
  Future<Comic?> getComicById(String id);
}
