import 'package:flutter/material.dart';

class NewMapView extends StatelessWidget {
  const NewMapView({super.key});

  static const routeName = '/new-map-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Column(children: [
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            ListTile(),
          ]),
        );
      }),
    );
  }
}
