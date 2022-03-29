// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

String articleToJson(Article data) => json.encode(data.toJson());

class Article {
  Article({
    required this.batchcomplete,
    required this.warnings,
    required this.query,
  });

  String batchcomplete;
  Warnings warnings;
  Query query;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        batchcomplete: json["batchcomplete"],
        warnings: Warnings.fromJson(json["warnings"]),
        query: Query.fromJson(json["query"]),
      );

  Map<String, dynamic> toJson() => {
        "batchcomplete": batchcomplete,
        "warnings": warnings.toJson(),
        "query": query.toJson(),
      };
}

class Query {
  Query({
    required this.pages,
  });

  Pages pages;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        pages: Pages.fromJson(json["pages"]),
      );

  Map<String, dynamic> toJson() => {
        "pages": pages.toJson(),
      };
}

class Pages {
  Pages({
    required this.pageId,
  });

  PageId pageId;

  factory Pages.fromJson(Map<String, dynamic> json) => Pages(
        pageId: PageId.fromJson(json[json.keys.first]),
      );

  Map<String, dynamic> toJson() => {
        "pageId": pageId.toJson(),
      };
}

class PageId {
  PageId({
    required this.pageid,
    this.ns,
    required this.title,
    required this.extract,
  });

  int pageid;
  int? ns;
  String title;
  String extract;

  factory PageId.fromJson(Map<String, dynamic> json) => PageId(
        pageid: json["pageid"],
        ns: json["ns"],
        title: json["title"],
        extract: json["extract"],
      );

  Map<String, dynamic> toJson() => {
        "pageid": pageid,
        "ns": ns,
        "title": title,
        "extract": extract,
      };
}

class Warnings {
  Warnings({
    required this.extracts,
  });

  Extracts extracts;

  factory Warnings.fromJson(Map<String, dynamic> json) => Warnings(
        extracts: Extracts.fromJson(json["extracts"]),
      );

  Map<String, dynamic> toJson() => {
        "extracts": extracts.toJson(),
      };
}

class Extracts {
  Extracts({
    this.empty,
  });

  String? empty;

  factory Extracts.fromJson(Map<String, dynamic> json) => Extracts(
        empty: json["*"],
      );

  Map<String, dynamic> toJson() => {
        "*": empty,
      };
}
