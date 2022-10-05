import 'package:flutter_event_calendar/models/queue_reservation.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource({List<Appointment> source}) {
    appointments = source;
  }
}
