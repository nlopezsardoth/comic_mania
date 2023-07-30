import '../../domain/datasources/comics_datasource.dart';
import '../../domain/entities/comic.dart';
import '../../domain/repository/comics_repository.dart';

class ComicRepositoryImpl extends ComicsRepository {
  final ComicsDatasource datasource;
  ComicRepositoryImpl(this.datasource);

  @override
  Future<List<Comic>> getComics({int offset = 0}) {
    return datasource.getComics(offset: offset);
  }
}
