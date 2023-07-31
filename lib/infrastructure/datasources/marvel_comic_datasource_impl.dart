import 'dart:developer';

import 'package:comic_mania/infrastructure/mappers/comic_mapper.dart';
import 'package:dio/dio.dart';

import '../../config/constants/environments.dart';
import '../../config/helpers/dio_interceptor.dart';
import '../../domain/datasources/comics_datasource.dart';
import '../../domain/entities/comic.dart';
import '../models/marvel/marvel_response.dart';
import '../service/encryption_service.dart';

class MarvelComicsDatasource extends ComicsDatasource {
  final dio = Dio(
    BaseOptions(
        baseUrl: 'http://gateway.marvel.com/v1/public',
        queryParameters: {
          "apikey": Environment.marvelPublicKey,
        }),
  )..interceptors.add(CustomLoggerInterceptor());

  @override
  Future<List<Comic>> getThisWeekComics({int offset = 0}) async {
    try {
      final Map<String, dynamic> queryParameters =
          await EncryptionService().marvelEncryption();

      queryParameters["limit"] = 20;
      queryParameters["offset"] = offset;
      queryParameters["dateDescriptor"] = "thisWeek";

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

  @override
  Future<List<Comic>> getLastWeekComics({int offset = 0}) async {
    try {
      final Map<String, dynamic> queryParameters =
          await EncryptionService().marvelEncryption();

      queryParameters["limit"] = 20;
      queryParameters["offset"] = offset;
      queryParameters["dateDescriptor"] = "lastWeek";

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

  @override
  Future<List<Comic>> getNextWeekComics({int offset = 0}) async {
    try {
      final Map<String, dynamic> queryParameters =
          await EncryptionService().marvelEncryption();

      queryParameters["limit"] = 20;
      queryParameters["offset"] = offset;
      queryParameters["dateDescriptor"] = "nextWeek";

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

  @override
  Future<List<Comic>> getThisMonthComics({int offset = 0}) async {
    try {
      final Map<String, dynamic> queryParameters =
          await EncryptionService().marvelEncryption();

      queryParameters["limit"] = 20;
      queryParameters["offset"] = offset;
      queryParameters["dateDescriptor"] = "thisMonth";

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

  @override
  Future<Comic?> getComicById(String id) async {
    try {
      final Map<String, dynamic> queryParameters =
          await EncryptionService().marvelEncryption();

      final response = await dio.get(
        '/comics/$id',
        queryParameters: queryParameters,
      );
      final marvelResponse = MarvelResponse.fromJson(response.data);

      final List<Comic> comics = marvelResponse.data.results
          .map((comicMarvel) => ComicMapper().marvelComicToEntity(comicMarvel))
          .toList();

      return comics[0];
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<List<Comic>> searchComics(String query) async {
    try {
      final Map<String, dynamic> queryParameters =
          await EncryptionService().marvelEncryption();

      queryParameters["title"] = query;

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
