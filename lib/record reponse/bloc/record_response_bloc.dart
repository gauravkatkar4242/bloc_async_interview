import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

import '../../timer.dart';

part 'record_response_event.dart';
part 'record_response_state.dart';

class RecordResponseBloc extends Bloc<RecordResponseEvent, RecordResponseState> {


  CameraController? _controller;
  final CountDownTimer _ticker = const CountDownTimer();
  StreamSubscription<int>? _tickerSubscription;

  RecordResponseBloc() : super(const CameraInitializingState(null)) {
    on<InitCameraEvent>(_initCamera);
    on<TimerTickedEvent>(_timerTicked);
    on<StartRecordingEvent>(_startRecording);
    on<StopRecordingEvent>(_getRecordedVideo);
    on<DisposeCameraEvent>(_disposeCamera);


  }

  Future<void> _initCamera(InitCameraEvent event, Emitter<RecordResponseState> emit) async {
    print("--- Event :- _initCamera :: Current State :- $state");
    try {
      var cameraList = await availableCameras(); // gets all available cameras from device

      if (_controller != null) {
        _tickerSubscription?.cancel();
        await _controller!.dispose();
      }
      CameraDescription cameraDescription;
      if (cameraList.length == 1) {
        cameraDescription = cameraList[0]; // for desktop
      } else {
        cameraDescription = cameraList[1]; // for mobile select front camera
      }
      final CameraController cameraController = CameraController(
        cameraDescription,
        ResolutionPreset.medium,
        enableAudio: true,
      );
      _controller = cameraController;
      if (cameraController.value.hasError) {
        emit(const ErrorInCameraState(null));
      }
      await cameraController.initialize();
      emit(ReverseCountDownInProgressState(_controller, -3));
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker
          .tick(ticks: -3)
          .listen((duration) => add(TimerTickedEvent(duration: duration)));

    } on CameraException catch (e) {
      emit(const ErrorInCameraState(null));
    }

  }

  void _timerTicked(TimerTickedEvent event, Emitter<RecordResponseState> emit) {
    print("_onTicked ${event.duration}");

    if (event.duration < 0) {
      // emit(CameraReadyState(_controller));
      emit(ReverseCountDownInProgressState(_controller, event.duration));
    } else if (event.duration == 0) {
      add(StartRecordingEvent());
      // emit(RecordingInProgressState(_controller));
    } else if (event.duration >= 1000) {
      add(StopRecordingEvent());
    } else {
      emit(RecordingInProgressState(_controller, event.duration));
    }
  }

  Future<void> _startRecording(StartRecordingEvent event, Emitter<RecordResponseState> emit) async {
    print("--- Event :- _startRecording :: CurrentState :- $state");

    if (_controller == null || _controller!.value.isRecordingVideo) {
      return;
    }
    try {
      await _controller!.startVideoRecording();

      emit(RecordingInProgressState(_controller, 0));

      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker
          .tick(ticks: 0)
          .listen((duration) => add(TimerTickedEvent(duration: duration)));

    } on CameraException catch (e) {
      //will set state to CameraExceptionState state
      emit(ErrorInCameraState(_controller));
    }
  }


  Future<void> _getRecordedVideo(StopRecordingEvent event, Emitter<RecordResponseState> emit) async {
    XFile? file = await _stoppedRecording();
    if (file == null) {
      emit(ErrorInCameraState(_controller));
      return;
    }
    if (file != null) {
      // file.saveTo("abd.mp4");
      // logic for saving and uploading video
    }
    emit(RecordingCompletedState(_controller));
  }

  Future<XFile?> _stoppedRecording() async {
    if (_controller == null || !_controller!.value.isRecordingVideo) {
      //will set state to CameraExceptionState state - Null video
      return null;
    }
    try {
      XFile file = await _controller!.stopVideoRecording();
      _tickerSubscription?.cancel();
      print("--- Event :- _stoppedRecording :: CurrentState :- $state");
      return file;
    } on CameraException catch (e) {
      //will set state to CameraExceptionState state
      return null;
    }
  }

  Future<void> _disposeCamera(DisposeCameraEvent event, Emitter<RecordResponseState> emit) async {

    if (_controller != null) {
      await _controller?.dispose();
      print("--- Event :- _disposeCamera :: CurrentState :- $state");
      print("Camera Disposed");
    }
    _tickerSubscription?.cancel();
    emit(const CameraDisposedState(null));

  }

}
