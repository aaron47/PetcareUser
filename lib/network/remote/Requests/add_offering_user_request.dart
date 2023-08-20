import 'dart:convert';

import 'package:flutter/material.dart';

AddOfferingUserRequest addOfferingUserRequestFromJson(String str) =>
    AddOfferingUserRequest.fromJson(json.decode(str));

String addOfferingUserRequestToJson(AddOfferingUserRequest data) =>
    json.encode(data.toJson());

class AddOfferingUserRequest {
  final String serviceId;
  final String userEmail;

  AddOfferingUserRequest({
    @required this.serviceId,
    @required this.userEmail,
  });

  factory AddOfferingUserRequest.fromJson(Map<String, dynamic> json) =>
      AddOfferingUserRequest(
        serviceId: json["serviceId"],
        userEmail: json["userEmail"],
      );

  Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
        "userEmail": userEmail,
      };
}
