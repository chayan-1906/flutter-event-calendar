import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    // print(response.body);
  } catch (e) {
    print('getAllReservationApi error = $e');
    return null;
  }
  return response;
}

Future<http.Response> getReservationById({
  @required String reservationId,
}) async {
  print("GetReservationById api called");
  http.Response response;
  if (isStringInvalid(reservationId)) {
    return null;
  }
  String url = '$baseUrl/user/reservation?reservationId=$reservationId';
  print('Get reservation by id: $url');
  response = await http.get(Uri.parse(url), headers: {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MjE5MjMxOTZkYzg1MGMyOWZhN2MyZTYiLCJwaG9uZU5vIjoiKzkxNzMxOTQzOTcyNSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY1NzYyMjE5NCwiZXhwIjoxNjgzNTQyMTk0fQ.GGzEnN9CiPs_8-jwueEzpctM6YdM-ZrvXH6CI36fGfk',
  });
  print(response.statusCode);
  // print(response.body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    print('GetReservationById : Success');
    // return true;
  } else if (response.statusCode == 400) {
    print('GetReservationById  : res id missing');
  } else if (response.statusCode == 401) {
    print('GetReservationById  : unauthorized');
  } else if (response.statusCode == 500) {
    print('100: ${response.body}');
    print('GetReservationById  : server error');
  } else if (response.statusCode == 402) {
    print('GetReservationById  : invalid reservation id');
  } else {
    print('GetReservationById error : ${response.statusCode}');
  }
  return response;
}
