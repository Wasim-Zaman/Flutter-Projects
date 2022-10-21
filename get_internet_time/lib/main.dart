import 'package:flutter/material.dart';

import 'package:ntp/ntp.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Internet Time",
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Future<DateTime> _checkTime(String lookupAddress) async {
    DateTime myTime;
    DateTime ntpTime;

    /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
    myTime = DateTime.now();

    /// Or get NTP offset (in milliseconds) and add it yourself
    final int offset =
        await NTP.getNtpOffset(localTime: myTime, lookUpAddress: lookupAddress);

    ntpTime = myTime.add(Duration(milliseconds: offset));

    return ntpTime;
  }

  DateTime? _time;

  @override
  Widget build(BuildContext context) {
    _checkTime('time.google.com').then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _time = pickedTime;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Time'),
      ),
      body: Center(
        child: Text(
          _time.toString(),
        ),
      ),
    );
  }
}
