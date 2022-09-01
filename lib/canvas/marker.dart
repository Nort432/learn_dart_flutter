import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:learn_dart_flutter/canvas/controller.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(38, 31),
    zoom: 30,
  );

  @override
  Widget build(BuildContext context) {
    final markers = fetchMarkers();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marker in canvas'),
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchMarkers(),
          builder: (context, data) {
            return GoogleMap(
              markers: data.data as Set<Marker>? ?? {},
              mapType: MapType.hybrid,
              myLocationButtonEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: initialCameraPosition,
            );
          },
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    Completer<GoogleMapController> _controller = Completer();
    _controller.complete(controller);
    // DashboardController.mapController = controller;
  }

  Future<Set<Marker>> fetchMarkers() async {
    double degree = 180+160;
    Uint8List bitMap = await Controller.createCanvas(
      text: 'UA10',
      degree: degree,
      iconSize: Controller.myIconSizeOval,
    );

    Set<Marker> markers = {};

    markers.add(
      Marker(
        markerId: const MarkerId('marId'),
        position: const LatLng(38, 31),
        rotation: degree,
        flat: true,
        icon: BitmapDescriptor.fromBytes(bitMap),
        // onTap: () => _onTapMarker(train.buttonTagId, latLng),
      ),
    );

    return markers;
  }
}
