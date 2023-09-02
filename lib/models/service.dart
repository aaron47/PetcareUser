import 'dart:convert';

import 'package:flutter/material.dart';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  final String id;
  final String serviceName;
  final List<String> usersOfferingService;
  final String description;
  final int duration;
  final String imageLink;
  final int price;
  final String title;

  Service({
    @required this.id,
    @required this.serviceName,
    @required this.usersOfferingService,
    @required this.description,
    @required this.duration,
    @required this.imageLink,
    @required this.price,
    @required this.title,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["_id"],
        serviceName: json["serviceName"],
        usersOfferingService: List<String>.from(json["usersOfferingService"]),
        description: json["description"],
        imageLink: json["imageLink"],
        duration: json["duration"],
        price: json["price"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "serviceName": serviceName,
        "usersOfferingService":
            List<dynamic>.from(usersOfferingService.map((x) => x)),
      };
}
