import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

import '../components/third_section.dart';
import '../components/first_section.dart';

import '../pages/map_view.dart';

class NewMapView extends StatefulWidget {
  const NewMapView({super.key});

  static const routeName = '/new-map-view';

  @override
  State<NewMapView> createState() => _NewMapViewState();
}

class _NewMapViewState extends State<NewMapView> {
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
    ////////////////////////////////////////////////////////////////////////
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

    ////////////////////////////////////////////////////////////////////////
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ...getFirstSection(context),
            // Map
            Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.45,
              child: Column(
                children: [
                  ListTile(
                    leading: const Text('Your location'),
                    trailing: TextButton(
                      onPressed: () {
                        // Show full map
                        // navigate to the second page and show the map
                        // Navigate to map view.
                        Navigator.of(context).pushNamed(
                          MapView.routeName,
                          arguments: {
                            'latitude': latitude,
                            'longitude': longitude,
                          },
                        );
                      },
                      child: const Text('View Full Map'),
                    ),
                  ),
                  // Google map
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GoogleMap(
                        compassEnabled: true,
                        indoorViewEnabled: true,
                        mapType: MapType.hybrid,
                        // mapType: MapType.terrain,

                        initialCameraPosition: initialPosition!,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        markers: Set<Marker>.of(_markers),
                      ),
                    ),
                  ),

                  const SizedBox(height: 2),
                  // List tile
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.location_on),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Bikasi Barat, '),
                        Text(
                          'Indonesia',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // third section
            getThirdSection(
              context,
              [
                {
                  'icon':
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Green_Building_-_MIT%2C_Cambridge%2C_MA_-_DSC05589.jpg/250px-Green_Building_-_MIT%2C_Cambridge%2C_MA_-_DSC05589.jpg',
                  'title': "Office",
                  'address': "JI, Merdeka",
                },
                {
                  'icon':
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Green_Building_-_MIT%2C_Cambridge%2C_MA_-_DSC05589.jpg/250px-Green_Building_-_MIT%2C_Cambridge%2C_MA_-_DSC05589.jpg',
                  'title': "Ruma Pakar",
                  'address': "JI, Gang Buntu",
                },
                {
                  'icon':
                      'https://cdn1.vectorstock.com/i/1000x1000/82/30/office-icon-in-trendy-flat-style-on-white-vector-21088230.jpg',
                  'title': "Ruma Pakar",
                  'address': "JI, Gang Buntu",
                },
                {
                  'icon':
                      'https://cdn1.vectorstock.com/i/1000x1000/82/30/office-icon-in-trendy-flat-style-on-white-vector-21088230.jpg',
                  'title': "Ruma Pakar",
                  'address': "JI, Gang Buntu",
                },
              ],
            ),
          ],
        ),
      ),
    );
  }
}
