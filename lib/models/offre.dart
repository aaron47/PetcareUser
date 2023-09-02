import 'package:flutter/material.dart';

class Offre {
  final String id;
  final String titre;
  final String description;
  final int prix;

  Offre(
      {@required this.id,
      @required this.titre,
      @required this.description,
      @required this.prix});

  factory Offre.fromJson(Map<String, dynamic> json) => Offre(
      id: json["_id"],
      titre: json["titre"],
      description: json["description"],
      prix: json["prix"]);
}
