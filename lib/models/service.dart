import 'dart:convert';

import 'package:flutter/material.dart';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  final String serviceName;
  final List<String> usersOfferingService;

  Service({
    @required this.serviceName,
    @required this.usersOfferingService,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceName: json["serviceName"],
        usersOfferingService:
            List<String>.from(json["usersOfferingService"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "serviceName": serviceName,
        "usersOfferingService":
            List<dynamic>.from(usersOfferingService.map((x) => x)),
      };
}
