// To parse this JSON data, do
//
//     final apiResultModel = apiResultModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ApiResultModel {
  ApiResultModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;

  factory ApiResultModel.fromRawJson(String str) =>
      ApiResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiResultModel.fromJson(Map<String, dynamic> json) => ApiResultModel(
        status: json["status"] == null ? null : json["status"],
        totalResults:
            json["totalResults"] == null ? null : json["totalResults"],
        articles: json["articles"] = List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status = status,
        "totalResults": totalResults == null ? null : totalResults,
        "articles": articles == null
            ? null
            : List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Source? source;
  dynamic author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime? publishedAt;
  String content;

  factory Article.fromRawJson(String str) => Article.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        url: json["url"] == null ? null : json["url"],
        urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
        publishedAt: json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source == null ? null : source!.toJson(),
        "author": author,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "url": url == null ? null : url,
        "urlToImage": urlToImage == null ? null : urlToImage,
        "publishedAt":
            publishedAt == null ? null : publishedAt!.toIso8601String(),
        "content": content == null ? null : content,
      };
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  Id? id;
  Name? name;

  factory Source.fromRawJson(String str) => Source.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] == null ? null : idValues.map[json["id"]],
        name: json["name"] == null ? null : nameValues.map[json["name"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : idValues.reverse[id],
        "name": name == null ? null : nameValues.reverse[name],
      };
}

enum Id { ESPN_CRIC_INFO }

final idValues = EnumValues({"espn-cric-info": Id.ESPN_CRIC_INFO});

enum Name { ESPN_CRIC_INFO }

final nameValues = EnumValues({"ESPN Cric Info": Name.ESPN_CRIC_INFO});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
