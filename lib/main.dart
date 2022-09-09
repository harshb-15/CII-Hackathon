// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hackathon/pages/all_info.dart';
import 'package:hackathon/pages/vehicle_photo.dart';
import 'package:hackathon/pages/which_vehicle.dart';
import 'package:hackathon/pages/whos_vehicle.dart';
import 'package:hackathon/providers/crash_data.dart';
import 'package:provider/provider.dart';

// import 'package:flutter_location_practice/location_page.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CrashData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hackathon',
        routes: {
          '/home': (context)=>MyHomePage(title: 'Hackathon'),
          "/vehicleOwner": (context) => VehicleOwner(),
          '/vehicleType': (context) => VehicleType(),
          '/vehiclePhoto': (context) => PickPhoto(),
          '/allInfo': (context) => AllInfo(),
        },
        home: MyHomePage(title: 'Hackathon'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // final db = FirebaseFirestore.instance;
    // db.collection('accidents').add({"area": "manipal"});
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ElevatedButton(
          child: Text("Report an accident"),
          onPressed: () {
            Navigator.of(context).pushNamed('/vehicleOwner');
          },
        ),
      ),
    );
  }
}
