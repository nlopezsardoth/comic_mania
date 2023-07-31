import '../../domain/datasources/comics_datasource.dart';
import '../../domain/entities/comic.dart';
import '../../domain/repository/comics_repository.dart';

class ComicRepositoryImpl extends ComicsRepository {
  final ComicsDatasource datasource;
  ComicRepositoryImpl(this.datasource);

  @override
  Future<List<Comic>> getThisWeekComics({int offset = 0}) {
    return datasource.getThisWeekComics(offset: offset);
  }

  @override
  Future<List<Comic>> getLastWeekComics({int offset = 0}) {
    return datasource.getLastWeekComics(offset: offset);
  }

  @override
  Future<List<Comic>> getNextWeekComics({int offset = 0}) {
    return datasource.getNextWeekComics(offset: offset);
  }

  @override
  Future<List<Comic>> getThisMonthComics({int offset = 0}) {
    return datasource.getThisMonthComics(offset: offset);
  }

  @override
  Future<Comic?> getComicById(String id) {
    return datasource.getComicById(id);
  }

  @override
  Future<List<Comic>> searchComics(String query) {
    return datasource.searchComics(query);
  }
}
