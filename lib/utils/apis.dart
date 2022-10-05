import 'dart:convert';

import 'package:flutter_event_calendar/utils/get_full_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/queue_reservation.dart';
import 'package:http/http.dart' as http;

import 'is_string_invalid.dart';

const String baseUrl = 'https://test.skywasolutions.com';

Future<http.Response> getAllReservationApi({
  DateTime startDate,
  DateTime endDate,
}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final businessId = pref.getString('businessId');
  http.Response response;
  try {
    String url;
    if (startDate == null || endDate == null) {
      DateTime today = DateTime.now();
      DateTime todayBeginning =
          DateTime(today.year, today.month, today.day, 0, 0, 0);
      DateTime todayEnd = todayBeginning.add(const Duration(days: 1));
      url = '$baseUrl/manager/getAllreservation?'
          'businessId=62c41676b00b4a68943644fa&' // Chandrima's Business
          '&startDate=2022-10-03&endDate=2022-10-07';
    } else {
      url = '$baseUrl/manager/getAllreservation?'
          'businessId=$businessId&'
          'startDate=$startDate&'
          'endDate=$endDate';
    }
    Uri uri = Uri.parse(url);
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MjE5MjMxOTZkYzg1MGMyOWZhN2MyZTYiLCJwaG9uZU5vIjoiKzkxNzMxOTQzOTcyNSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY1NzYyMjE5NCwiZXhwIjoxNjgzNTQyMTk0fQ.GGzEnN9CiPs_8-jwueEzpctM6YdM-ZrvXH6CI36fGfk',
      'Content-Type': 'application/json'
    };
    print(uri);

    response = await http.get(uri, headers: headers);
    print(response.statusCode);
    print(response.body);
  } catch (e) {
    print('getAllReservationApi error = $e');
    return null;
  }
  return response;
}
