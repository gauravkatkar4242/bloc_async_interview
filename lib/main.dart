import 'package:bloc_async_interview/route_generator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: '/cameraTestCompletedPage',
      initialRoute: '/cameraTestingPage',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
