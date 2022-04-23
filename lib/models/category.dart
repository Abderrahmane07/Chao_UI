// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.batchcomplete,
    required this.limits,
    required this.query,
  });

  String? batchcomplete;
  Limits limits;
  Query query;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        batchcomplete: json["batchcomplete"],
        limits: Limits.fromJson(json["limits"]),
        query: Query.fromJson(json["query"]),
      );

  Map<String, dynamic> toJson() => {
        "batchcomplete": batchcomplete,
        "limits": limits.toJson(),
        "query": query.toJson(),
      };
}

class Limits {
  Limits({
    required this.categorymembers,
  });

  int categorymembers;

  factory Limits.fromJson(Map<String, dynamic> json) => Limits(
        categorymembers: json["categorymembers"],
      );

  Map<String, dynamic> toJson() => {
        "categorymembers": categorymembers,
      };
}

class Query {
  Query({
    required this.categorymembers,
  });

  List<Categorymember> categorymembers;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        categorymembers: List<Categorymember>.from(
            json["categorymembers"].map((x) => Categorymember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categorymembers":
            List<dynamic>.from(categorymembers.map((x) => x.toJson())),
      };
}

class Categorymember {
  Categorymember({
    required this.pageid,
    required this.ns,
    required this.title,
  });

  int pageid;
  int ns;
  String title;

  factory Categorymember.fromJson(Map<String, dynamic> json) => Categorymember(
        pageid: json["pageid"],
        ns: json["ns"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "pageid": pageid,
        "ns": ns,
        "title": title,
      };
}
