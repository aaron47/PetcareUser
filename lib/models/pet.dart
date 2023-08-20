import 'dart:convert';

import 'package:flutter/material.dart';

Pet petFromJson(String str) => Pet.fromJson(json.decode(str));

String petToJson(Pet data) => json.encode(data.toJson());

class Pet {
  final String id; // Add an ID field if it's present in the JSON
  final String petName;
  final int petAge; // Change to int
  final String petImageLink;
  final String petType;
  final String petBreed;
  final String petGender;
  final String petBloodPressure;
  final String petBoneDensity;
  final double petWeight; // Change to double
  final String petOwner;

  Pet({
    this.id,
    @required this.petName,
    @required this.petAge,
    @required this.petImageLink,
    @required this.petType,
    @required this.petBreed,
    @required this.petGender,
    @required this.petBloodPressure,
    @required this.petBoneDensity,
    @required this.petWeight,
    @required this.petOwner,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json["_id"],
      // Use the correct key if it's different
      petName: json["petName"],
      petAge: json["petAge"],
      petImageLink: json["petImageLink"],
      petType: json["petType"],
      petBreed: json["petBreed"],
      petGender: json["petGender"],
      petBloodPressure: json["petBloodPressure"],
      petBoneDensity: json["petBoneDensity"],
      petWeight: json["petWeight"].toDouble(),
      // Convert to double
      petOwner: json["petOwner"],
    );
  }

  Map<String, dynamic> toJson() => {
        "petName": petName,
        "petAge": petAge,
        "petImageLink": petImageLink,
        "petType": petType,
        "petBreed": petBreed,
        "petGender": petGender,
        "petBloodPressure": petBloodPressure,
        "petBoneDensity": petBoneDensity,
        "petWeight": petWeight,
        "petOwner": petOwner,
      };
}
