import 'package:flutter/material.dart';

class Article {
  final String id;
  final String details;
  final String type;
  final String imageLink;

  Article(
      {@required this.id,
      @required this.details,
      @required this.type,
      @required this.imageLink});

  factory Article.fromJson(Map<String, dynamic> json) => Article(
      id: json["_id"],
      details: json["details"],
      type: json["type"],
      imageLink: json["imageLink"]);
}
