import 'package:bloc_async_interview/record%20reponse/bloc/question_part_cubit.dart';
import 'package:bloc_async_interview/record%20reponse/bloc/record_response_bloc.dart';
import 'package:bloc_async_interview/route_generator.dart';
import 'package:bloc_async_interview/test%20camera/bloc/camera_testing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
      providers: [
        BlocProvider<CameraTestingBloc>(
          create: (BuildContext context) => CameraTestingBloc(),
        ),
        BlocProvider<RecordResponseBloc>(
            create: (BuildContext context) => RecordResponseBloc()),
        BlocProvider<QuestionPartCubit>(
            create: (BuildContext context) => QuestionPartCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        // initialRoute: '/cameraTestingPage',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
