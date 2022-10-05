import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/models/queue_reservation.dart';
import 'package:flutter_event_calendar/utils/meeting_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'utils/apis.dart';
import 'utils/appointments_data_source.dart';
import 'utils/appointments_list.dart';
import 'utils/get_full_name.dart';
import 'utils/is_string_invalid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Appointment> skywaAppointmentList = [];

  List<Appointment> getMeetings() {
    List<Appointment> meetings = <Appointment>[];
    final DateTime now = DateTime.now();
    final DateTime startTime = DateTime(now.year, now.month, now.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
      Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: 'Conference',
        color: CupertinoColors.systemTeal,
        recurrenceRule: 'FREQ=DAILY;COUNT=10',
        // isAllDay: true,
      ),
    );
    return meetings;
  }

  List<Appointment> getAppointments() {
    return skywaAppointmentList;
  }

  Future<void> initAll() async {
    setState(() {
      isLoading = true;
    });
    getAllReservationApi().then((response) {
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        final listFromResponse = jsonDecode(response.body);
        for (var appointmentInJson in listFromResponse) {
          var appointmentFromJson = Appointment(
            id: appointmentInJson['ReservationID'],
            subject: getFullName(
              firstName: appointmentInJson['firstName'],
              middleName: appointmentInJson['middleName'],
              lastName: appointmentInJson['lastName'],
            ),
            startTime:
                !isStringInvalid(appointmentInJson["ReservationStartTime"])
                    ? DateTime.parse(appointmentInJson["ReservationStartTime"])
                        .toLocal()
                    : DateTime.now(),
            endTime: !isStringInvalid(appointmentInJson["ReservationEndTime"])
                ? DateTime.parse(appointmentInJson["ReservationEndTime"])
                    .toLocal()
                : DateTime.now(),
          );
          setState(() {
            skywaAppointmentList.add(appointmentFromJson);
          });
        }
      } else {
        print(
            'getAllReservationApi error: ${response.statusCode}- ${response.body}');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SfCalendar(
              view: CalendarView.month,
              firstDayOfWeek: 1,
              initialDisplayDate: DateTime.now(),
              initialSelectedDate: DateTime.now(),
              showNavigationArrow: true,
              allowViewNavigation: true,
              // dataSource: MeetingDataSource(source: getMeetings()),
              dataSource: AppointmentDataSource(source: getAppointments()),
            ),
    );
  }
}
