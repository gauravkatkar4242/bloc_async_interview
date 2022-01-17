part of 'record_response_bloc.dart';

abstract class RecordResponseEvent extends Equatable {
  const RecordResponseEvent();
  @override
  List<Object?> get props =>[];

}
class InitCameraEvent extends RecordResponseEvent{}
class StartRecordingEvent extends RecordResponseEvent{}
class TimerTickedEvent extends RecordResponseEvent{
  const TimerTickedEvent({required this.duration});
  final int duration;

}
class StopRecordingEvent extends RecordResponseEvent{}
class DisposeCameraEvent extends RecordResponseEvent{}


