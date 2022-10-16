import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReservationById(reservationId: widget.reservationId).then((response) {
      // print(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details Screen'),
        elevation: 0.0,
      ),
      body: Center(
        child: Image.asset('assets/images/appointment_details_screen.png'),
      ),
    );
  }
}
