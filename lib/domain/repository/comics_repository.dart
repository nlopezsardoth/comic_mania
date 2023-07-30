import '../entities/comic.dart';

abstract class ComicsRepository {
  Future<List<Comic>> getComics({int offset = 0});
}
