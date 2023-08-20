import 'dart:convert';

import 'package:flutter/material.dart';

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    @required this.email,
    @required this.password,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
