import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as ImageWidget;

import '../pages/items_detail.dart';
import '../models/data_model.dart';

class ListItem extends StatelessWidget {
  final DataModel data;
  const ListItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(
            ItemsDetail.routeName,
            arguments: {
              'image': data.image!.small,
              'title': data.title,
              'description': data.description,
              'latitude': data.latitude,
              'longitude': data.longitude,
            },
          );
        },
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.grey,
            ),
          ),
          child: ImageWidget.Image.network(
            data.image!.small!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('Unable to get image!'));
            },
          ),
        ),
        title: Text(data.title!),
        subtitle: Text(data.address!),
      ),
    );
  }
}
