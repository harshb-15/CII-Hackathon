import 'package:flutter/material.dart';
import 'package:hackathon/providers/crash_data.dart';
import 'package:provider/provider.dart';

class VehicleType extends StatelessWidget {
  const VehicleType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CrashData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Vehicle Type"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  data.setVehicleType("Car");
                  Navigator.of(context).pushNamed('/vehiclePhoto');
                  // data.addAccident();
                },
                child: const Text("Car"),
              ),
              ElevatedButton(
                onPressed: () {
                  data.setVehicleType("Bike");
                  Navigator.of(context).pushNamed('/vehiclePhoto');
                  // data.addAccident();
                },
                child: const Text("Bike"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  data.setVehicleType("Truck");
                  Navigator.of(context).pushNamed('/vehiclePhoto');
                  // data.addAccident();
                },
                child: const Text("Truck"),
              ),
              ElevatedButton(
                onPressed: () {
                  data.setVehicleType("Cycle");
                  Navigator.of(context).pushNamed('/vehiclePhoto');
                  // data.addAccident();
                },
                child: const Text("Cycle"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
