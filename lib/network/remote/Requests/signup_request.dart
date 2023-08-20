import 'dart:convert';
import 'package:flutter/material.dart';

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  final String fullName;
  final String email;
  final String phone;
  final String imageLink;
  final String address;
  final String password;
  final String gender;
  final String role;

  SignUpRequest({
    @required this.fullName,
    @required this.email,
    @required this.phone,
    @required this.imageLink,
    @required this.address,
    @required this.password,
    @required this.gender,
    @required this.role,
  });

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "imageLink": imageLink,
        "address": address,
        "password": password,
        "role": role,
        "gender": gender,
      };
}
