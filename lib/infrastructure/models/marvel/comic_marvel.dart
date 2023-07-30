class ComicMarvel {
  int id;
  int digitalId;
  String title;
  int issueNumber;
  String variantDescription;
  String? description;
  String modified;
  String isbn;
  String upc;
  String diamondCode;
  String ean;
  String issn;
  String format;
  int pageCount;
  List<TextObject> textObjects;
  String resourceUri;
  List<Url> urls;
  SourceItem series;
  List<SourceItem> variants;
  List<dynamic> collections;
  List<dynamic> collectedIssues;
  List<Date> dates;
  List<Price> prices;
  Thumbnail thumbnail;
  List<Thumbnail> images;
  MarvelCreators creators;
  Sources characters;
  Stories stories;
  Sources events;

  ComicMarvel({
    required this.id,
    required this.digitalId,
    required this.title,
    required this.issueNumber,
    required this.variantDescription,
    this.description,
    required this.modified,
    required this.isbn,
    required this.upc,
    required this.diamondCode,
    required this.ean,
    required this.issn,
    required this.format,
    required this.pageCount,
    required this.textObjects,
    required this.resourceUri,
    required this.urls,
    required this.series,
    required this.variants,
    required this.collections,
    required this.collectedIssues,
    required this.dates,
    required this.prices,
    required this.thumbnail,
    required this.images,
    required this.creators,
    required this.characters,
    required this.stories,
    required this.events,
  });

  factory ComicMarvel.fromJson(Map<String, dynamic> json) => ComicMarvel(
        id: json["id"],
        digitalId: json["digitalId"],
        title: json["title"],
        issueNumber: json["issueNumber"],
        variantDescription: json["variantDescription"],
        description: json["description"],
        modified: json["modified"],
        isbn: json["isbn"],
        upc: json["upc"],
        diamondCode: json["diamondCode"],
        ean: json["ean"],
        issn: json["issn"],
        format: json["format"],
        pageCount: json["pageCount"],
        textObjects: List<TextObject>.from(
            json["textObjects"].map((x) => TextObject.fromJson(x))),
        resourceUri: json["resourceURI"],
        urls: List<Url>.from(json["urls"].map((x) => Url.fromJson(x))),
        series: SourceItem.fromJson(json["series"]),
        variants: List<SourceItem>.from(
            json["variants"].map((x) => SourceItem.fromJson(x))),
        collections: List<dynamic>.from(json["collections"].map((x) => x)),
        collectedIssues:
            List<dynamic>.from(json["collectedIssues"].map((x) => x)),
        dates: List<Date>.from(json["dates"].map((x) => Date.fromJson(x))),
        prices: List<Price>.from(json["prices"].map((x) => Price.fromJson(x))),
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        images: List<Thumbnail>.from(
            json["images"].map((x) => Thumbnail.fromJson(x))),
        creators: MarvelCreators.fromJson(json["creators"]),
        characters: Sources.fromJson(json["characters"]),
        stories: Stories.fromJson(json["stories"]),
        events: Sources.fromJson(json["events"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "digitalId": digitalId,
        "title": title,
        "issueNumber": issueNumber,
        "variantDescription": variantDescription,
        "description": description,
        "modified": modified,
        "isbn": isbn,
        "upc": upc,
        "diamondCode": diamondCode,
        "ean": ean,
        "issn": issn,
        "format": format,
        "pageCount": pageCount,
        "textObjects": List<dynamic>.from(textObjects.map((x) => x.toJson())),
        "resourceURI": resourceUri,
        "urls": List<dynamic>.from(urls.map((x) => x.toJson())),
        "series": series.toJson(),
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
        "collections": List<dynamic>.from(collections.map((x) => x)),
        "collectedIssues": List<dynamic>.from(collectedIssues.map((x) => x)),
        "dates": List<dynamic>.from(dates.map((x) => x.toJson())),
        "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
        "thumbnail": thumbnail.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "creators": creators.toJson(),
        "characters": characters.toJson(),
        "stories": stories.toJson(),
        "events": events.toJson(),
      };
}

class Sources {
  int available;
  String collectionUri;
  List<SourceItem> items;
  int returned;

  Sources({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  factory Sources.fromJson(Map<String, dynamic> json) => Sources(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<SourceItem>.from(
            json["items"].map((x) => SourceItem.fromJson(x))),
        returned: json["returned"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
      };
}

class SourceItem {
  String resourceUri;
  String name;

  SourceItem({
    required this.resourceUri,
    required this.name,
  });

  factory SourceItem.fromJson(Map<String, dynamic> json) => SourceItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
      };
}

class MarvelCreators {
  int available;
  String collectionUri;
  List<MarvelCreator> items;
  int returned;

  MarvelCreators({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  factory MarvelCreators.fromJson(Map<String, dynamic> json) => MarvelCreators(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<MarvelCreator>.from(
            json["items"].map((x) => MarvelCreator.fromJson(x))),
        returned: json["returned"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
      };
}

class MarvelCreator {
  String? resourceUri;
  String? name;
  String? role;

  MarvelCreator({
    this.resourceUri,
    this.name,
    this.role,
  });

  factory MarvelCreator.fromJson(Map<String, dynamic> json) => MarvelCreator(
        resourceUri: json["resourceURI"],
        name: json["name"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
        "role": role,
      };
}

// enum Role {
//   colorist,
//   editor,
//   inker,
//   letterer,
//   penciler,
//   penilerCover,
//   penciller,
//   writer
// }

class Date {
  String? type;
  String? date;

  Date({
    this.type,
    this.date,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        type: json["type"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "date": date,
      };
}

class Thumbnail {
  String? path;
  String? extension;

  Thumbnail({
    this.path,
    this.extension,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json["path"],
        extension: json["extension"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "extension": extension,
      };
}

class Price {
  String type;
  double price;

  Price({
    required this.type,
    required this.price,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        type: json["type"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "price": price,
      };
}

class Stories {
  int available;
  String collectionUri;
  List<StoriesItem> items;
  int returned;

  Stories({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  factory Stories.fromJson(Map<String, dynamic> json) => Stories(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<StoriesItem>.from(
            json["items"].map((x) => StoriesItem.fromJson(x))),
        returned: json["returned"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
      };
}

class StoriesItem {
  String? resourceUri;
  String? name;
  String? type;

  StoriesItem({
    this.resourceUri,
    this.name,
    this.type,
  });

  factory StoriesItem.fromJson(Map<String, dynamic> json) => StoriesItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
        "type": type,
      };
}

class TextObject {
  String? type;
  String? language;
  String? text;

  TextObject({
    this.type,
    this.language,
    this.text,
  });

  factory TextObject.fromJson(Map<String, dynamic> json) => TextObject(
        type: json["type"],
        language: json["language"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "language": language,
        "text": text,
      };
}

class Url {
  String? type;
  String? url;

  Url({
    this.type,
    this.url,
  });

  factory Url.fromJson(Map<String, dynamic> json) => Url(
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "url": url,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
