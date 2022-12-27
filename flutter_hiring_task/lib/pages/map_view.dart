import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  static const routeName = '/map-view';

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  // controller for the GoogleMap
  final Completer<GoogleMapController> _controller = Completer();

  // initial and target camera positions
  CameraPosition? targetPosition;
  CameraPosition? initialPosition;

  Future<Position> _getCurrentLocation() async {
    final parameters = await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  final List<Marker> _markers = <Marker>[];

  List<Marker>? list;

  @override
  Widget build(BuildContext context) {
    final parameters =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final latitude = parameters['latitude'];
    final longitude = parameters['longitude'];

    list = [
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(double.parse(latitude), double.parse(longitude)),
        infoWindow: const InfoWindow(title: 'some Info '),
      ),
    ];
    _markers.addAll(list!);
    initialPosition = CameraPosition(
      target: LatLng(double.parse(latitude), double.parse(longitude)),
      zoom: -50,
    );

    targetPosition = CameraPosition(
      target: LatLng(double.parse(latitude), double.parse(longitude)),
      zoom: -50,
    );

    // this method is used to set the current marker position to the map
    void loadData() {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Longitude: ${double.parse(longitude)} Latitude: ${double.parse(latitude)}'),
        ),
      );
      _getCurrentLocation().then((value) async {
        _markers.add(
          Marker(
            markerId: const MarkerId('SomeId'),
            position: LatLng(
              double.parse(latitude),
              double.parse(longitude),
            ),
          ),
        );

        // this method is used to animate the camera to the target position
        final GoogleMapController controller = await _controller.future;
        CameraPosition kGooglePlex = CameraPosition(
          target: LatLng(double.parse(latitude), double.parse(longitude)),
          zoom: 10,
        );
        controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
        setState(() {});
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          loadData();
        },
        label: const Text('Navigate'),
        icon: const Icon(Icons.directions_boat),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPosition!,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_markers),
      ),
    );
  }
}
