import 'dart:convert';

import 'comic_marvel.dart';

MarvelResponse marvelResponseFromJson(String str) =>
    MarvelResponse.fromJson(json.decode(str));

String marvelResponseToJson(MarvelResponse data) => json.encode(data.toJson());

class MarvelResponse {
  int code;
  String status;
  String copyright;
  String attributionText;
  String attributionHtml;
  String etag;
  Data data;

  MarvelResponse({
    required this.code,
    required this.status,
    required this.copyright,
    required this.attributionText,
    required this.attributionHtml,
    required this.etag,
    required this.data,
  });

  factory MarvelResponse.fromJson(Map<String, dynamic> json) => MarvelResponse(
        code: json["code"],
        status: json["status"],
        copyright: json["copyright"],
        attributionText: json["attributionText"],
        attributionHtml: json["attributionHTML"],
        etag: json["etag"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "copyright": copyright,
        "attributionText": attributionText,
        "attributionHTML": attributionHtml,
        "etag": etag,
        "data": data.toJson(),
      };
}

class Data {
  int offset;
  int limit;
  int total;
  int count;
  List<ComicMarvel> results;

  Data({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        offset: json["offset"],
        limit: json["limit"],
        total: json["total"],
        count: json["count"],
        results: List<ComicMarvel>.from(
            json["results"].map((x) => ComicMarvel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "total": total,
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
