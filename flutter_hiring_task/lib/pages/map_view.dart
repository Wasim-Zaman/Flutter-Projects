import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

import '../models/extra_data.dart';

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
    final data = Data().getData;

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
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: initialPosition!,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Set<Marker>.of(_markers),
          ),
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.3,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    final imageUrl = data[index]['imageUrl'];
                    final type = data[index]['type'];
                    final mins = data[index]['mins'];
                    final pax = data[index]['pax'];
                    final price = data[index]['price'];
                    final oldPrice = data[index]['old_price'];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                              width: 300,
                              height: 80,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                type!,
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.timelapse),
                                      Text(mins!),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.timelapse),
                                        Text(pax!),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text(
                                oldPrice!,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                price!,
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
