import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  Place({
    this.id,
    required this.name,
    required this.phone,
    required this.latLng,
    required this.cep,
    required this.address,
    required this.favorite,
    required this.images,
  });
  Place.fromJson(Map<dynamic, dynamic> data)
      : name = data['name'],
        phone = data['phone'],
        latLng = LatLng(data['latLng'].latitude, data['latLng'].longitude),
        address = data['address'],
        favorite = false,
        cep = data['cep'],
        images = data['images'].map<String>((i) => i.toString()).toList();
  String? id;
  DocumentReference? ref;
  final String name;
  final String phone;
  final LatLng latLng;
  final String cep;
  final String address;
  bool favorite;
  final List<String> images;
}
