import 'package:flutter/material.dart';

class CreateReservation {
  final String sitterId;
  final String petId;
  final String serviceId;
  final String type;
  final String dateDeb;
  final int duration;
  final int prixTotal;

  CreateReservation(
      {@required this.sitterId,
      @required this.petId,
      @required this.serviceId,
      @required this.type,
      @required this.dateDeb,
      @required this.duration,
      @required this.prixTotal});

  Map<String, dynamic> toJson() {
    return {
      "sitterId": sitterId,
      "petId": petId,
      "serviceId": serviceId,
      "type": type,
      "dateDeb": dateDeb,
      "duration": duration,
      "prixTotal": prixTotal,
    };
  }
}
