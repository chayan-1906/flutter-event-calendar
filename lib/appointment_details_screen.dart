import 'dart:convert';

import 'package:flutter/material.dart';

import 'utils/apis.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final String reservationId;

  const AppointmentDetailsScreen({
    Key key,
    @required this.reservationId,
  }) : super(key: key);

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  bool isLoading = false;
  String name;
  String startTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    getReservationById(reservationId: widget.reservationId).then((response) {
      print(response.body);
      name = jsonDecode(response.body)['firstName'];
      startTime = jsonDecode(response.body)['reservationStartTime'];
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(title: Text(name), elevation: 0.0),
            body: Column(
              children: [
                Text('Reservation Start time: $startTime'),
              ],
            ),
          );
  }
}
