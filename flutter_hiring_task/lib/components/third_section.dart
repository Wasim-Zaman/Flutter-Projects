import 'package:flutter/material.dart';

Widget getThirdSection(BuildContext context, List<dynamic> listOfData) {
  return Expanded(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Where To ?',
                  style: Theme.of(context).textTheme.headline1,
                ),
                trailing: TextButton(
                  child: const Text('Manage'),
                  onPressed: () {},
                ),
              ),
              // GridView...
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1 / 1.1,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(listOfData[index]['icon']),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(listOfData[index]['title']),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // const CircleAvatar(
                                    //   backgroundImage: NetworkImage(
                                    //       'https://cdn-icons-png.flaticon.com/512/7474/7474511.png'),
                                    // ),
                                    const CircleAvatar(
                                        child: Icon(Icons.location_on)),
                                    Text(listOfData[index]['address']),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: listOfData.length,
                  scrollDirection: Axis.horizontal,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
