import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GeolocatorHome(),
    );
  }
}

class GeolocatorHome extends StatefulWidget {
  const GeolocatorHome({Key? key}) : super(key: key);

  @override
  State<GeolocatorHome> createState() => _GeolocatorHomeState();
}

class _GeolocatorHomeState extends State<GeolocatorHome> {
  String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text ?? ''),
            ElevatedButton(
              onPressed: () async {
                LocationPermission permission;
                permission = await Geolocator.requestPermission();

                Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);

                String lat = position.latitude.toString();
                String lon = position.longitude.toString();

                setState(() {
                  text = 'Latitude: $lat\nLongitude: $lon';
                });
              },
              child: const Text('Fetch geo'),
            ),
          ],
        ),
      ),
    );
  }
}
