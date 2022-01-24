part of 'camera_testing_bloc.dart';

abstract class CameraTestingState extends Equatable {
  final CameraController? cameraController;

  const CameraTestingState(this.cameraController, {this.timeElapsed = 0});

  final int timeElapsed;

  @override
  List<Object> get props => [];
}

class CameraInitializingState extends CameraTestingState {
  const CameraInitializingState(CameraController? cameraController)
      : super(cameraController);
}

class CameraReadyState extends CameraTestingState {
  const CameraReadyState(CameraController? cameraController)
      : super(cameraController);
}

class RecordingCompletedState extends CameraTestingState {
  const RecordingCompletedState(CameraController? cameraController)
      : super(cameraController);
}

class RecordingInProgressState extends CameraTestingState {
  const RecordingInProgressState(
      CameraController? cameraController, this.duration)
      : super(cameraController, timeElapsed: duration);
  final int duration;

  @override
  List<Object> get props => [duration];
}

class CameraDisposedState extends CameraTestingState {
  const CameraDisposedState(CameraController? cameraController)
      : super(cameraController);
}

class ErrorInCameraState extends CameraTestingState {
  const ErrorInCameraState(CameraController? cameraController)
      : super(cameraController);
}
