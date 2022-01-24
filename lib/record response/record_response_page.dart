import 'package:bloc_async_interview/record%20response/bloc/record_response_bloc.dart';
import 'package:bloc_async_interview/record%20response/question_part.dart';
import 'package:bloc_async_interview/record%20response/response_page_camera_screen.dart';
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
  var bloc;

  @override
  void didChangeDependencies() {
    // Add event to init Camera
    bloc = context.read<RecordResponseBloc>()..add(InitCameraEvent());
    WidgetsBinding.instance!.addObserver(this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    bloc.add(DisposeCameraEvent());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      context.read<RecordResponseBloc>().add(DisposeCameraEvent());
      // Free up memory when camera not active
      debugPrint(
          "------------------AppLifecycleState.inactive--------------------");
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera
      debugPrint(
          "------------------AppLifecycleState.resumed--------------------");
      context.read<RecordResponseBloc>().add(InitCameraEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: kIsWeb ? _webLayout() : _mobileLayout()));
  }

  Widget _webLayout() {
    return LayoutBuilder(builder: (context, constraints) {
      var maxHeight = constraints.maxHeight;
      var maxWidth = constraints.maxWidth;
      if (maxHeight > 450 && maxWidth > 650) {
        // Resize the layout as height and width changes
        return Container(
          color: Colors.black12,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              SizedBox(
                height: maxHeight * 0.7,
                width: maxWidth * 0.6,
                child: ResponsePageCameraScreen(),
              ),
              SizedBox(
                  // color: Colors.black12,
                  height: maxHeight * 0.2,
                  width: maxWidth * 0.6,
                  child: const QuestionPart()),
            ],
          ),
        );
      } else {
        //Fixed height and Width and enable scrolling
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
                    SizedBox(
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
              ),
            ),
          ),
        );
      }
    });
  }

  Widget _mobileLayout() {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          ResponsePageCameraScreen(),
          const QuestionPart(),
        ],
      );
    });
  }
}
