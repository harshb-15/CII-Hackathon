import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';

// import 'package:geocoding/geocoding.dart';
import 'package:hackathon/providers/crash_data.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class PickPhoto extends StatefulWidget {
  const PickPhoto({Key? key}) : super(key: key);

  @override
  State<PickPhoto> createState() => _PickPhotoState();
}

class _PickPhotoState extends State<PickPhoto> {
  File? img;
  LocationData? _currentPosition;
  String _address = "";
  Location location = Location();

  fetchLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentPosition = currentLocation;
      });
    });
    final coordinates =
        Coordinates(_currentPosition!.latitude, _currentPosition!.longitude);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = address.first;
    _address = first.addressLine.toString();
  }

  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        img = imageTemporary;
      });
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        img = imageTemporary;
      });
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }

  void removeImage() {
    setState(() {
      img = null;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final data = Provider.of<CrashData>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Photo"),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.8,
              height: size.width * 0.8,
              color: Colors.grey[200],
              child: (img == null)
                  ? const Text("No image chosen")
                  : Image.file(
                      img!,
                      fit: BoxFit.fill,
                    ),
            ),
            ElevatedButton(
              onPressed: () {
                pickImageFromGallery();
              },
              child: const Text("Pick from Gallery"),
            ),
            ElevatedButton(
              onPressed: () {
                pickImageFromCamera();
              },
              child: const Text("Click a photo"),
            ),
            ElevatedButton(
              onPressed: () {
                removeImage();
              },
              child: const Text("Remove Image"),
            ),
            ElevatedButton(
              onPressed: () {
                data.setImage(img!);
                data.setPosition(_currentPosition);
                data.setAddress(_address);
                Navigator.of(context).pushNamed('/allInfo');
              },
              child: const Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
