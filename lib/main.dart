import 'package:flutter/material.dart';

import 'home_page.dart';

/*https://www.youtube.com/watch?v=3OROjbAQS8Y*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Calendar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.redAccent,
      ),
      home: const HomePage(),
    );
  }
}
