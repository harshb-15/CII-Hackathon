import 'package:flutter/material.dart';
import 'package:hackathon/providers/crash_data.dart';
import 'package:provider/provider.dart';

class VehicleOwner extends StatelessWidget {
  const VehicleOwner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CrashData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Vehicle Owner"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              data.setOwnVehicle(true);
              Navigator.of(context).pushNamed('/vehicleType');
            },
            child: const Text("Own Vehicle"),
          ),
          ElevatedButton(
            onPressed: () {
              data.setOwnVehicle(false);
              Navigator.of(context).pushNamed('/vehicleType');
            },
            child: const Text("Other's Vehicle"),
          ),
        ],
      ),
    );
  }
}
