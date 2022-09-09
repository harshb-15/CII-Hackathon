import 'package:flutter/material.dart';
import 'package:hackathon/providers/crash_data.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class AllInfo extends StatelessWidget {
  AllInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CrashData>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accident Report"),
      ),
      body: Container(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Vehicle Owner: ${data.ownVehicle == true ? "Own" : "Other"}"),
            Text("Vehicle Type: ${data.vehicleType}"),
            Image.file(
              data.image,
              width: size.width * 0.5,
              height: size.width * 0.5,
            ),
            Text(data.address),
            ElevatedButton(
              onPressed: () {
                data.addAccident();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home',
                  (Route route) => false,
                );
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
