import 'dart:convert';

import 'package:flutter/material.dart';

Reservation reservationFromJson(String str) => Reservation.fromJson(json.decode(str));

class Reservation {
  final String ownerId;
  final String sitterId;
  final String petId;
  final String serviceId;
  final String createdAt;
  final String status;
  final String duration;
  final String budget;

  Reservation({
    @required this.ownerId,
    @required this.sitterId,
    @required this.petId,
    @required this.serviceId,
    @required this.createdAt,
    @required this.status,
    @required this.duration,
    @required this.budget,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
    ownerId: json["ownerId"],
    sitterId: json["sitterId"],
    petId: json["petId"],
    serviceId: json["serviceId"],
    createdAt: json["createdAt"],
    status: json["status"],
    duration: json["duration"],
    budget: json["budget"],
  );
}