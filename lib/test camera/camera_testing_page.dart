import 'package:bloc_async_interview/test%20camera/bloc/camera_testing_bloc.dart';
import 'package:bloc_async_interview/test%20camera/testing_page_camera_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraTestingPage extends StatefulWidget {
  const CameraTestingPage({Key? key}) : super(key: key);

  @override
  _CameraTestingPageState createState() => _CameraTestingPageState();
}

class _CameraTestingPageState extends State<CameraTestingPage>
    with WidgetsBindingObserver {
  var bloc;

  @override
  void didChangeDependencies() {
    bloc = context.read<CameraTestingBloc>()..add(InitCameraEvent());
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
      context.read<CameraTestingBloc>().add(DisposeCameraEvent());
      // Free up memory when camera not active
      debugPrint(
          "------------------AppLifecycleState.inactive--------------------");
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      debugPrint(
          "------------------AppLifecycleState.resumed--------------------");
      context.read<CameraTestingBloc>().add(InitCameraEvent());
    } else if (state == AppLifecycleState.paused) {
      // Reinitialize the camera with same properties
      debugPrint(
          "------------------AppLifecycleState.paused--------------------");
      context.read<CameraTestingBloc>().add(DisposeCameraEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: kIsWeb ? _webLayout() : _mobileLayout()));
  }

  Widget _webLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        var maxHeight = constraints.maxHeight;
        var maxWidth = constraints.maxWidth;
        if (maxHeight > 500 && maxWidth > 600) {
          // resize the content
          return Container(
            padding: const EdgeInsets.only(top: 50),
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: maxHeight * 0.7,
                    width: maxWidth * 0.6,
                    child: TestingPageCameraScreen()),
                SizedBox(
                  // height: maxHeight * 0.3,
                  width: maxWidth * 0.25,
                  child: _textContent(),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  children: [
                    SizedBox(
                        height: 300,
                        width: 300,
                        child: TestingPageCameraScreen()),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      // height: 300,
                      width: 200,
                      child: _textContent(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _mobileLayout() {
    return LayoutBuilder(builder: (context, constraints) {
      // var maxHeight = constraints.maxHeight;
      var maxWidth = constraints.maxWidth;
      return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: maxWidth * 0.9,
                child: _textContent()),
            Expanded(child: TestingPageCameraScreen())
          ],
        ),
      );
    });
  }

  Widget _textContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Test your camera & microphone",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Speak this phrase out loud while recording the practice video: 'Two blue fish swam in the tank.'",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          if (kIsWeb) ...{
            const Divider(
              color: Colors.black54,
              thickness: 0.5,
              height: 20,
            ),
            const Text(
              "You must test your video and audio by recording a practice video before moving ahead.",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(
              height: kIsWeb ? 20 : 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white10,
              ), // set the background color
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("Go Next "),
                  Icon(Icons.arrow_forward, size: 15)
                ],
              ),
              onPressed: () {
                // Navigator.of(context).pushReplacementNamed(
                //   '/nextPage',
                // );
              },
            ),
          }
        ],
      ),
    );
  }
}
