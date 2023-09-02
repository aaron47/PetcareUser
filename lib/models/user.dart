import 'dart:convert';

import 'package:flutter/material.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String phone;
  final String gender;
  final String imageLink;
  final String address;

  User({
    @required this.id,
    @required this.fullName,
    @required this.email,
    @required this.role,
    @required this.phone,
    @required this.imageLink,
    @required this.address,
    @required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        role: json["role"],
        phone: json["phone"],
        gender: json["gender"],
        imageLink: json["imageLink"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "role": role,
        "phone": phone,
        "gender": gender,
        "imageLink": imageLink,
        "address": address,
      };
}
