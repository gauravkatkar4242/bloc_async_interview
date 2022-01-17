part of 'camera_testing_bloc.dart';

abstract class CameraTestingState extends Equatable {
  final CameraController? cameraController;

  const CameraTestingState(this.cameraController, {this.timeElasped = 0});
  final int timeElasped;
}

class CameraInitializingState extends CameraTestingState {

  const CameraInitializingState(CameraController? cameraController) : super(cameraController);
  @override
  List<Object> get props => [];
}

class CameraReadyState extends CameraTestingState {

  const CameraReadyState(CameraController? cameraController) : super(cameraController);
  @override
  List<Object> get props => [];
}

class RecordingInProgressState extends CameraTestingState {

  RecordingInProgressState(CameraController? cameraController,  this.duration) : super(cameraController,timeElasped: duration);
  int duration;
  @override
  List<Object> get props => [duration];
}

class CameraDisposedState extends CameraTestingState {

  const CameraDisposedState(CameraController? cameraController) : super(cameraController);
  @override
  List<Object> get props => [];
}

class ErrorInCameraState extends CameraTestingState {

  const ErrorInCameraState(CameraController? cameraController) : super(cameraController);
  @override
  List<Object> get props => [];
}
