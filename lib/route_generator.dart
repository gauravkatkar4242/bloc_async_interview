import 'package:bloc_async_interview/camera%20test%20completed/camera_test_completed_page.dart';
import 'package:bloc_async_interview/home_page.dart';
import 'package:bloc_async_interview/record%20reponse/record_response_page.dart';
import 'package:bloc_async_interview/test%20camera/camera_testing_page.dart';
import 'package:flutter/material.dart';

import 'next_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/cameraTestingPage':
        return MaterialPageRoute(
          builder: (_) => const CameraTestingPage(),
        );

      case '/recordResponsePage':
        return MaterialPageRoute(
          builder: (_) => const RecordResponsePage(),
        );

      case '/nextPage':
        return MaterialPageRoute(
          builder: (_) => const NextPage(),
        );

      case '/cameraTestCompletedPage':
        return MaterialPageRoute(
          builder: (_) => const CameraTestCompletedPage(),
        );

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
