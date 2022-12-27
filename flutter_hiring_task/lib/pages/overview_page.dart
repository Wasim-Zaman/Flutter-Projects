import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/list_item.dart';
import '../models/data_model.dart';

class OverviewPage extends StatefulWidget {
  static const routeName = '/overview-page';
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  // list that will hold the data
  List<DataModel> _dataModelList = [];

  Future<List<DataModel>> _fetchData() async {
    const url =
        'https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json';
    final header = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body.toString());
        // print(responseBody);
        for (var item in responseBody['data']) {
          _dataModelList.add(DataModel.fromJson(item));
        }
      } else {
        throw Exception('Failed to load data');
      }
      return _dataModelList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List View'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.error.toString()),
                  ElevatedButton(
                    onPressed: () {
                      // refresh the page
                      setState(() {});
                    },
                    child: const Text('Refresh'),
                  ),
                ],
              ));
            } else {
              final jsonData = snapshot.data as List<DataModel>;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListItem(data: jsonData[index]);
                      },
                      itemCount: _dataModelList.length,
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
