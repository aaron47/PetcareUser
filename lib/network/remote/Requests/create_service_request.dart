import 'dart:convert';
import 'package:flutter/material.dart';

String createServiceRequestToJson(CreateServiceRequest data) =>
    json.encode(data.toJson());

class CreateServiceRequest {
  final String serviceName;
  final String userEmail;

  CreateServiceRequest({
    @required this.serviceName,
    @required this.userEmail,
  });

  Map<String, dynamic> toJson() => {
        "serviceName": serviceName,
        "userEmail": userEmail,
      };
}
