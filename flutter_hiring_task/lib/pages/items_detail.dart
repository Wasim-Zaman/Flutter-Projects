import 'package:flutter/material.dart';

import './new_map_view.dart';
import './map_view.dart';

class ItemsDetail extends StatelessWidget {
  const ItemsDetail({super.key});

  static const routeName = '/items-detail';

  @override
  Widget build(BuildContext context) {
    final parameters =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final image = parameters['image'];
    final title = parameters['title'];
    final description = parameters['description'];
    final latitude = parameters['latitude'];
    final longitude = parameters['longitude'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to map view.
              // Navigator.of(context).pushNamed(
              //   MapView.routeName,
              //   arguments: {
              //     'latitude': latitude,
              //     'longitude': longitude,
              //   },
              // );
              Navigator.of(context).pushNamed(
                NewMapView.routeName,
                arguments: {
                  'latitude': latitude,
                  'longitude': longitude,
                },
              );
            },
            icon: const Icon(Icons.location_on),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.grey,
                ),
              ),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Unable to get image!'));
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "$title",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
