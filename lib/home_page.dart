import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/appointment_details_screen.dart';
import 'package:flutter_event_calendar/models/queue_reservation.dart';
import 'package:flutter_event_calendar/skywa_choice_chip.dart';
import 'package:skywa_framework_widgets/skywa_alert_dialog.dart';
import 'package:skywa_framework_widgets/skywa_elevated_button.dart';
import 'package:skywa_framework_widgets/skywa_radio_group.dart';
import 'package:skywa_framework_widgets/skywa_text_button.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'utils/apis.dart';
import 'utils/appointments_data_source.dart';
import 'utils/get_full_name.dart';
import 'utils/is_string_invalid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  final CalendarController _calendarController = CalendarController();
  // CalendarView calendarView = CalendarView.month;
  List<Appointment> skywaAppointmentList = [];
  List<Appointment> filteredSkywaAppointmentList = [];
  List<String> availableAppointmentTypes = [
    'Show All',
    'Doctor Monteray Has a long name',
    'Dr Kerry',
    'Sloop John B',
    'New Service',
    'apt 1',
    'apt2',
    'ap3',
    'apt5',
    'apt4',
  ];
  String selectedApptTypeName;

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
    return filteredSkywaAppointmentList;
  }

  Future<void> initAll({String selectedApptTypeName}) async {
    print('initAll called with $selectedApptTypeName');
    setState(() {
      isLoading = true;
    });
    skywaAppointmentList.clear();
    filteredSkywaAppointmentList.clear();
    getAllReservationApi().then((response) {
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        final listFromResponse = jsonDecode(response.body);
        List<QueueReservation> pastAppointments = [];
        for (var queueInJson in listFromResponse) {
          var queueFromJson = QueueReservation.fromJson(queueInJson);
          pastAppointments.add(queueFromJson);
        }
        for (var pastAppointment in pastAppointments) {
          var appointmentFromJson = Appointment(
            id: pastAppointment.reservationID,
            color: Colors.deepPurpleAccent,
            subject: pastAppointment.fullName,
            startTime: !isStringInvalid(
                    pastAppointment.reservationStartTime.toString())
                ? pastAppointment.reservationStartTime.toLocal()
                : DateTime.now(),
            endTime:
                !isStringInvalid(pastAppointment.reservationEndTime.toString())
                    ? pastAppointment.reservationEndTime.toLocal()
                    : DateTime.now(),
            notes:
                'appointmentTypeId: ${pastAppointment.appointmentTypeId}, appointmentTypeName: ${pastAppointment.appointmentTypeName}, providerId: ${pastAppointment.slotBookingDetails.providerId}, providerName: ${pastAppointment.slotBookingDetails.providerName}',
          );
          setState(() {
            skywaAppointmentList.add(appointmentFromJson);
            filteredSkywaAppointmentList.add(appointmentFromJson);
          });
        }
      } else {
        print(
            'getAllReservationApi error: ${response.statusCode}- ${response.body}');
      }
      if (selectedApptTypeName != 'Show All') {
        filteredSkywaAppointmentList = skywaAppointmentList.where((element) {
          // print(element.notes);
          return element.notes.contains(selectedApptTypeName.toString());
        }).toList();
      }
      print(filteredSkywaAppointmentList.length);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController.view = CalendarView.month;
    initAll(selectedApptTypeName: 'Show All');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Event Calendar'),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              SkywaAlertDialog.success(
                context: context,
                content: StatefulBuilder(
                  builder: (context, builderSetState) {
                    return Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.40,
                                  child: SkywaRadioGroup(
                                    // width: MediaQuery.of(context).size.width * 0.50,
                                    texts: availableAppointmentTypes,
                                    backgroundColor: Colors.transparent,
                                    onChanged: (String selectedOption) {
                                      builderSetState(() {
                                        selectedApptTypeName = selectedOption;
                                      });
                                    },
                                    selectedValue: selectedApptTypeName,
                                  ),
                                ),
                                SkywaElevatedButton.save(
                                  context: context,
                                  text: 'Applyyyy',
                                  onTap: () {
                                    Navigator.pop(context);
                                    initAll(
                                      selectedApptTypeName:
                                          selectedApptTypeName,
                                    ).then((value) {
                                      if (isLoading && mounted) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
            icon: const Icon(Icons.filter_alt_rounded),
          ),
          PopupMenuButton(itemBuilder: (context) {
            return const [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Month"),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Week"),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Text("Schedule"),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: Text("Day"),
              ),
              PopupMenuItem<int>(
                value: 4,
                child: Text("Timeline Month"),
              ),
              PopupMenuItem<int>(
                value: 5,
                child: Text("Timeline Week"),
              ),
              PopupMenuItem<int>(
                value: 6,
                child: Text("Timeline Day"),
              ),
            ];
          }, onSelected: (value) {
            setState(() {
              if (value == 0) {
                _calendarController.view = CalendarView.month;
              } else if (value == 1) {
                _calendarController.view = CalendarView.week;
              } else if (value == 2) {
                _calendarController.view = CalendarView.schedule;
              } else if (value == 3) {
                _calendarController.view = CalendarView.day;
              } else if (value == 4) {
                _calendarController.view = CalendarView.timelineMonth;
              } else if (value == 5) {
                _calendarController.view = CalendarView.timelineWeek;
              } else if (value == 6) {
                _calendarController.view = CalendarView.timelineDay;
              }
            });
          }),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SfCalendar(
              controller: _calendarController,
              view: _calendarController.view,
              firstDayOfWeek: 1,
              showCurrentTimeIndicator: true,
              // cellBorderColor: Colors.teal,
              // todayHighlightColor: Colors.cyan,
              showDatePickerButton: true,
              initialDisplayDate: DateTime.now(),
              initialSelectedDate: DateTime.now(),
              showNavigationArrow: true,
              allowViewNavigation: true,
              // dataSource: MeetingDataSource(source: getMeetings()),
              dataSource: AppointmentDataSource(source: getAppointments()),
              onTap: (CalendarTapDetails calendarTapDetails) {
                // print(calendarTapDetails);
                CalendarView previousView = _calendarController.view;
                if (calendarTapDetails.appointments.length == 1) {
                  // print(calendarTapDetails.appointments.first.id);
                  setState(() {
                    _calendarController.view = CalendarView.month;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AppointmentDetailsScreen(
                        reservationId: calendarTapDetails.appointments.first.id,
                      );
                    }),
                  );
                } else if (calendarTapDetails.appointments.length >= 2) {
                  // print(calendarTapDetails.appointments);
                }
              },
            ),
    );
  }
}
