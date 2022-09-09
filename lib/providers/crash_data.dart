// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:location/location.dart';

class CrashData with ChangeNotifier {
  final uuid = const Uuid();
  bool _ownVehicle = true;
  String _vehicleType = "Car";
  File? _image;
  LocationData? _pos;
  String _address = "";

  String _id = "";
  String _imageUrl = "";
  final db = FirebaseFirestore.instance;
  final fs = FirebaseStorage.instance;

  bool get ownVehicle {
    return _ownVehicle;
  }

  String get vehicleType {
    return _vehicleType;
  }

  File get image {
    return _image!;
  }

  LocationData? get position {
    return _pos!;
  }

  String get address {
    return _address;
  }

  void setAddress(String str) {
    _address = str;
  }

  void setPosition(LocationData? p) {
    _pos = p;
  }

  void setOwnVehicle(bool isOwn) {
    _ownVehicle = isOwn;
  }

  void setVehicleType(String vType) {
    _vehicleType = vType;
  }

  void setImage(File fl) {
    _image = fl;
  }

  void reset() {
    _ownVehicle = true;
    _vehicleType = "Car";
    _image = null;
    _id = "";
    _imageUrl = "";
    _address = "";
  }

  void setId() {
    _id = uuid.v1();
  }

  Future<void> addAccident() async {
    setId();
    await uploadImage();
    await db.collection('accidents').doc(_id).set({
      "ownVehicle": _ownVehicle,
      "vehicleType": vehicleType,
      "id": _id,
      "imageUrl": _imageUrl,
      "address": _address,
      "latitude": _pos!.latitude.toString(),
      "longitude": _pos!.longitude.toString(),
    });
    reset();
  }

  Future<void> uploadImage() async {
    var snapShot = await fs.ref().child('images/$_id').putFile(_image!);
    var downloadUrl = await snapShot.ref.getDownloadURL();
    _imageUrl = downloadUrl;
  }
}
