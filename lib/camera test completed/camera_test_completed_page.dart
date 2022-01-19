import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CameraTestCompletedPage extends StatefulWidget {
  const CameraTestCompletedPage({Key? key}) : super(key: key);

  @override
  _CameraTestCompletedPageState createState() => _CameraTestCompletedPageState();
}

class _CameraTestCompletedPageState extends State<CameraTestCompletedPage> {
  @override
  Widget build(BuildContext context) {
    return
      // MultiBlocProvider(
      //   providers: [
      //     BlocProvider<CameraTestingBloc>(
      //       create: (BuildContext context) => CameraTestingBloc(),
      //     ),
      //   ],
      //   child:
      Scaffold(
          appBar: AppBar(
            title: const Text("Testing Page"),
          ),
          body: kIsWeb ? _webLayout() : _mobileLayout());
    // );
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
                Container(
                    color: Colors.blueGrey,
                    height: maxHeight * 0.7,
                    width: maxWidth * 0.6,
                    child: Center(child: const Text("Video will be played here"))),
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
                     Container(
                        color: Colors.blueGrey,
                        height: 300,
                        width: 300,
                        child: const Text("Video will be played here")),
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
      var maxHeight = constraints.maxHeight;
      var maxWidth = constraints.maxWidth;
      return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: maxWidth * 0.9,
                child: _textContent()),
            const Expanded(child: Center(child: Text("Video will be played here")))
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
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Play the video to check your audio & video quality. If you face any issues with your microphone/camera, then switch to a different device or contact your administrator.",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black, fontSize: 14),
          ),
          // if (!kIsWeb) ...{
          const Divider(
            color: Colors.black54,
            thickness: 0.5,
            height: 20,
          ),
          const Text(
            "If everything is good to go, then move ahead. ",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
          const SizedBox(
            height: kIsWeb ? 20 : 10,
          ),
          ElevatedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("Go Next "),
                Icon(Icons.arrow_forward, size: 15)
              ],
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                '/nextPage',
              );
            },
          )
          // }
        ],
      ),
    );
  }
}
