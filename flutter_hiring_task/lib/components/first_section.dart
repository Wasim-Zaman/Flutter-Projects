import 'package:flutter/material.dart';

List<Widget> getFirstSection(BuildContext context) => [
      const ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        trailing: Icon(Icons.music_note),
      ),
      Container(
        width: double.infinity,
        child: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Hi, Ahmad Fauzi',
            textAlign: TextAlign.left,
          ),
        ),
      ),
      ListTile(
        leading: Text(
          'Where are you going today',
          style: Theme.of(context).textTheme.headline1,
          softWrap: true,
        ),
        trailing: const Icon(Icons.search),
      ),
    ];
