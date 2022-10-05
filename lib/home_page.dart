import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/utils/meeting_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Appointment> getAppointments() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 1,
        initialDisplayDate: DateTime.now(),
        initialSelectedDate: DateTime.now(),
        dataSource: MeetingDataSource(source: getAppointments()),
      ),
    );
  }
}
