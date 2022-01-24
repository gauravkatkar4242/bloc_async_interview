part of 'record_response_bloc.dart';

abstract class RecordResponseState extends Equatable {
  final CameraController? cameraController;

  const RecordResponseState(this.cameraController, {this.timeElapsed = 0});

  final int timeElapsed;

  @override
  List<Object> get props => [];
}

class CameraInitializingState extends RecordResponseState {
  const CameraInitializingState(CameraController? cameraController)
      : super(cameraController);
}

class ReverseCountDownInProgressState extends RecordResponseState {
  const ReverseCountDownInProgressState(
      CameraController? cameraController, this.duration)
      : super(cameraController, timeElapsed: duration);
  final int duration;

  @override
  List<Object> get props => [duration];
}

class RecordingInProgressState extends RecordResponseState {
  const RecordingInProgressState(
      CameraController? cameraController, this.duration)
      : super(cameraController, timeElapsed: duration);
  final int duration;

  @override
  List<Object> get props => [duration];
}

class CameraDisposedState extends RecordResponseState {
  const CameraDisposedState(CameraController? cameraController)
      : super(cameraController);
}

class RecordingCompletedState extends RecordResponseState {
  const RecordingCompletedState(CameraController? cameraController)
      : super(cameraController);
}

class ErrorInCameraState extends RecordResponseState {
  const ErrorInCameraState(CameraController? cameraController)
      : super(cameraController);
}
