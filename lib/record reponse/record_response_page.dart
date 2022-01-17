import 'package:bloc_async_interview/record%20reponse/bloc/record_response_bloc.dart';
import 'package:bloc_async_interview/record%20reponse/question_part.dart';
import 'package:bloc_async_interview/record%20reponse/response_page_camera_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordResponsePage extends StatefulWidget {
  const RecordResponsePage({Key? key}) : super(key: key);

  @override
  _RecordResponsePageState createState() => _RecordResponsePageState();
}

class _RecordResponsePageState extends State<RecordResponsePage>
    with WidgetsBindingObserver {
  var cameraBloc;

  @override
  void didChangeDependencies() {
    cameraBloc = BlocProvider.of<RecordResponseBloc>(
        context) /*...cameraBloc.add(InitializingControllerEvent())*/;
    cameraBloc.add(InitCameraEvent());
    WidgetsBinding.instance!.addObserver(this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    cameraBloc.add(DisposeCameraEvent());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      context.read<RecordResponseBloc>().add(DisposeCameraEvent());
      // Free up memory when camera not active
      print("------------------AppLifecycleState.inactive--------------------");
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      print("------------------AppLifecycleState.resumed--------------------");
      context.read<RecordResponseBloc>().add(InitCameraEvent());
    } else if (state == AppLifecycleState.paused) {
      // Reinitialize the camera with same properties
      print("------------------AppLifecycleState.paused--------------------");
      context.read<RecordResponseBloc>().add(DisposeCameraEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Record Response Page"),
        ),
        body: kIsWeb ? _webLayout() : _mobileLayout());
  }

  Widget _webLayout() {
    return LayoutBuilder(builder: (context, constraints) {
      var maxHeight = constraints.maxHeight;
      var maxWidth = constraints.maxWidth;
      if (maxHeight > 450 && maxWidth > 650) {
        return Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                height: maxHeight * 0.6,
                width: maxWidth * 0.6,
                child: ResponsePageCameraScreen(),
              ),
              Container(
                  color: Colors.black12,
                  // height: maxHeight * 0.2,
                  width: maxWidth * 0.6,
                  child: const QuestionPart()),
            ],
          ),
        );
      } else {
        return Center(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 300,
                            width: 400,
                            child: ResponsePageCameraScreen(),
                          ),
                          Container(
                              color: Colors.black12,
                              // height: 100,
                              width: 400,
                              child: const QuestionPart()),
                        ],
                      ),
                    ))));
      }
    });
  }

  Widget _mobileLayout() {
    return LayoutBuilder(builder: (context, constraints) {
      var maxHeight = constraints.maxHeight;
      var maxWidth = constraints.maxWidth;
      // return ResponsePageCameraScreen();
      return Stack(
        children: [
          Container(
            child: ResponsePageCameraScreen(),
          ),
          Container(
            child: const QuestionPart(),
            color: Colors.white,
          ),
        ],
      );
    });
  }
}
