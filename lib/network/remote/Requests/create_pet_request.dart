import 'dart:convert';

import 'package:flutter/material.dart';

String createPetRequestToJson(CreatePetRequest data) =>
    json.encode(data.toJson());

class CreatePetRequest {
  final String petName;
  final String petAge;
  final String petImageLink;
  final String petType;
  final String petBreed;
  final String petGender;
  final String petWeight;
  final String petOwner;

  CreatePetRequest({
    @required this.petName,
    @required this.petAge,
    @required this.petImageLink,
    @required this.petType,
    @required this.petBreed,
    @required this.petGender,
    @required this.petWeight,
    @required this.petOwner,
  });

  Map<String, dynamic> toJson() => {
        "petName": petName,
        "petAge": petAge,
        "petImageLink": petImageLink,
        "petType": petType,
        "petBreed": petBreed,
        "petGender": petGender,
        "petWeight": petWeight,
        "petOwner": petOwner,
      };
}
