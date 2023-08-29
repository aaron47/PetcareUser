import 'dart:convert';

import 'package:flutter/material.dart';

Reservation reservationFromJson(String str) =>
    Reservation.fromJson(json.decode(str));

class Reservation {
  final String id;
  final String sitterId;
  final String petId;
  final String serviceId;
  final String type;
  final String dateDeb;
  final String dateFin;
  final String status;
  final int prixTotal;

  Reservation({
    @required this.id,
    @required this.sitterId,
    @required this.petId,
    @required this.serviceId,
    @required this.type,
    @required this.dateDeb,
    @required this.dateFin,
    @required this.status,
    @required this.prixTotal,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        id: json["_id"],
        sitterId: json["sitterId"],
        petId: json["petId"],
        serviceId: json["serviceId"],
        type: json["type"],
        dateDeb: json["dateDeb"],
        dateFin: json["dateFin"],
        status: json["status"],
        prixTotal: json["prixTotal"],
      );
}
