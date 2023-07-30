import 'dart:developer';

import 'package:comic_mania/infrastructure/mappers/comic_mapper.dart';
import 'package:dio/dio.dart';

import '../../config/helpers/dio_interceptor.dart';
import '../../domain/datasources/comics_datasource.dart';
import '../../domain/entities/comic.dart';
import '../models/marvel/marvel_response.dart';
import '../service/encryption_service.dart';

class MarvelComicsDatasource extends ComicsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://gateway.marvel.com/v1/public',
    ),
  )..interceptors.add(CustomLoggerInterceptor());

  @override
  Future<List<Comic>> getComics({int offset = 0}) async {
    try {
      final Map<String, dynamic> queryParameters =
          await EncryptionService().marvelEncryption();

      final response = await dio.get(
        '/comics',
        queryParameters: queryParameters,
      );
      final marvelResponse = MarvelResponse.fromJson(response.data);

      final List<Comic> comics = marvelResponse.data.results
          .map((comicMarvel) => ComicMapper().marvelComicToEntity(comicMarvel))
          .toList();

      return comics;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
