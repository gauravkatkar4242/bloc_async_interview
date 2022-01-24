import 'package:bloc_async_interview/camera%20test%20completed/camera_test_completed_page.dart';
import 'package:bloc_async_interview/home_page.dart';
import 'package:bloc_async_interview/record%20response/bloc/question_part_cubit.dart';
import 'package:bloc_async_interview/record%20response/bloc/record_response_bloc.dart';
import 'package:bloc_async_interview/record%20response/record_response_page.dart';
import 'package:bloc_async_interview/screen%20size/screen_size_cubit.dart';
import 'package:bloc_async_interview/test%20camera/bloc/camera_testing_bloc.dart';
import 'package:bloc_async_interview/test%20camera/camera_testing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'next_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ScreenSizeCubit>(
                  create: (BuildContext context) => ScreenSizeCubit(),
                  child: const HomePage(),
                ));

      case '/cameraTestingPage':
        return MaterialPageRoute(
            builder: (_) => BlocProvider<CameraTestingBloc>(
                  create: (BuildContext context) => CameraTestingBloc(),
                  child: const CameraTestingPage(),
                ));

      case '/recordResponsePage':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<RecordResponseBloc>(
                        create: (BuildContext context) => RecordResponseBloc()),
                    BlocProvider<QuestionPartCubit>(
                        create: (BuildContext context) => QuestionPartCubit()),
                  ],
                  child: const RecordResponsePage(),
                ));

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
