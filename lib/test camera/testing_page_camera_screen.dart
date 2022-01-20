import 'package:bloc_async_interview/test%20camera/bloc/camera_testing_bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TestingPageCameraScreen extends StatefulWidget
    with WidgetsBindingObserver {
  TestingPageCameraScreen({Key? key}) : super(key: key);

  @override
  State<TestingPageCameraScreen> createState() =>
      _TestingPageCameraScreenState();
}

class _TestingPageCameraScreenState extends State<TestingPageCameraScreen> {
  // @override
  @override
  Widget build(BuildContext context) {
    var cameraBloc = BlocProvider.of<CameraTestingBloc>(context);

    return BlocConsumer<CameraTestingBloc, CameraTestingState>(
      builder: (context, state) {
        // _controller = context.select((CameraBloc bloc) => bloc.state.cameraController);
        if (state is CameraInitializingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CameraDisposedState) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.red,),
          );
        }
         else if (state is ErrorInCameraState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Issue in Camera", style: TextStyle(fontSize: 30),),
                const Text("Press Button to Retry", style: TextStyle(fontSize: 30),),
                ElevatedButton(
                    onPressed: () => context
                        .read<CameraTestingBloc>()
                        .add(InitCameraEvent()),
                    child: const Icon(Icons.reset_tv_rounded ,size: 30,))
              ],
            ),
          );
        } else {
          return LayoutBuilder(builder: (context, constraints) {
            int timer = context.select(
                (CameraTestingBloc bloc) => bloc.state.timeElapsed);
            int min = (timer / 60).round();
            int sec = (timer % 60);

            return Stack(
              children: [
                kIsWeb
                    /* for camera screen web Button 👇*/
                    ? AspectRatio(
                        aspectRatio:
                            (constraints.maxWidth / constraints.maxHeight),
                        child:
                            CameraPreview(cameraBloc.state.cameraController!))

                    /* for camera screen mobile Button 👇*/
                    : Transform.scale(
                        scale: 1 /
                            (cameraBloc
                                    .state.cameraController!.value.aspectRatio *
                                (constraints.maxWidth / constraints.maxHeight)),
                        alignment: Alignment.topCenter,
                        child: CameraPreview(cameraBloc.state.cameraController!),
                      ),
                if (state is CameraReadyState) ...[
                  /* for Start recording Button 👇*/
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.deepOrangeAccent),
                                  elevation: MaterialStateProperty.all(5.0)),
                              onPressed: () => context
                                  .read<CameraTestingBloc>()
                                  .add(StartRecordingEvent()),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Start Recording",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.not_started_outlined)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                if (state is RecordingInProgressState) ...[
                  /* for Stop recording Button 👇*/
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: FittedBox(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              elevation: MaterialStateProperty.all(5.0)),
                          onPressed: () => context
                              .read<CameraTestingBloc>()
                              .add(StopRecordingEvent()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Stop Recoding",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.stop_circle_outlined)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  /* for recording inProgress Icon 👇 */
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 8),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 16.0,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.black26,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              child: const Text(
                                "REC",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  /* for timer 👇 */
                  Align(
                    alignment: Alignment.topRight,
                    child: FittedBox(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 12, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            child: Text(
                              "${min.toString().padLeft(2, '0')} : ${sec.toString().padLeft(2, '0')}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                  )
                ],
              ],
            );
          });
        }
      },
      listener: (context, state) {
        print("--- Current State :- $state ---");
        if (state is RecordingCompletedState) {
          Navigator.of(context).pushReplacementNamed(
            '/cameraTestCompletedPage',
          );
          // context.read<CameraTestingBloc>().add(DisposeCameraEvent());
        }
      },
    );
  }


}
