part of 'camera_testing_bloc.dart';

abstract class CameraTestingEvent extends Equatable {
  const CameraTestingEvent();
  @override
  List<Object?> get props =>[];

}

class InitCameraEvent extends CameraTestingEvent{}
class StartRecordingEvent extends CameraTestingEvent{}
class TimerTickedEvent extends CameraTestingEvent{
  const TimerTickedEvent({required this.duration});
  final int duration;

}
class StopRecordingEvent extends CameraTestingEvent{}
class DisposeCameraEvent extends CameraTestingEvent{}


