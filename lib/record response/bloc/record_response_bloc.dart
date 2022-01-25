import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../timer.dart';

part 'record_response_event.dart';

part 'record_response_state.dart';

class RecordResponseBloc
    extends Bloc<RecordResponseEvent, RecordResponseState> {
  CameraController? _controller;

  // for timer Subscription
  final CountDownTimer _ticker = const CountDownTimer();
  StreamSubscription<int>? _tickerSubscription;

  int endTime = 100;

  RecordResponseBloc() : super(const CameraInitializingState(null)) {
    on<InitCameraEvent>(_initCamera);
    on<TimerTickedEvent>(_timerTicked);
    on<StartRecordingEvent>(_startRecording);
    on<StopRecordingEvent>(_getRecordedVideo);
    on<DisposeCameraEvent>(_disposeCamera);
  }

  Future<void> _initCamera(
      InitCameraEvent event, Emitter<RecordResponseState> emit) async {
    debugPrint("--- Event :- _initCamera :: Current State :- $state");
    try {
      var cameraList =
          await availableCameras(); // gets all available cameras from device

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
      emit(ReverseCountDownInProgressState(_controller, 3));
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker
          .tick(ticks: 3)
          .listen((duration) => add(TimerTickedEvent(duration: duration)));
    } on CameraException catch (e) {
      emit(const ErrorInCameraState(null));
    }
  }

  void _timerTicked(TimerTickedEvent event, Emitter<RecordResponseState> emit) {
    debugPrint("_onTicked ${event.duration}");

    if (event.duration > 0 && state is ReverseCountDownInProgressState) {
      // if timer is -3, -2, -1, emit ReverseCountDownInProgressState state
      emit(ReverseCountDownInProgressState(_controller, event.duration));
    } else if (event.duration == 0) {
      // when timer is 0 start the recording
      add(StartRecordingEvent());
    } else if (event.duration >= endTime) {
      // for auto-stop recording... here it will stop recording after 1000 secs
      add(StopRecordingEvent());
    } else {
      // else emit recording RecordingInProgressState
      emit(RecordingInProgressState(_controller, event.duration));
    }
  }

  Future<void> _startRecording(
      StartRecordingEvent event, Emitter<RecordResponseState> emit) async {
    debugPrint("--- Event :- _startRecording :: CurrentState :- $state");

    if (_controller == null || _controller!.value.isRecordingVideo) {
      return;
    }
    try {
      await _controller!.startVideoRecording();
      emit(RecordingInProgressState(_controller, endTime));
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker
          .tick(ticks: endTime)
          .listen((duration) => add(TimerTickedEvent(duration: duration)));

    } on CameraException catch (e) {
      //will set state to ErrorInCameraState state
      emit(ErrorInCameraState(_controller));
    }
  }

  Future<void> _getRecordedVideo(
      StopRecordingEvent event, Emitter<RecordResponseState> emit) async {
    XFile? file = await _stoppedRecording();
    if (file == null) {
      // if recorded file is null emit ErrorInCameraState
      emit(ErrorInCameraState(_controller));
      return;
    } else {
      // file.saveTo("abd.mp4");
      // logic for saving and uploading video will be here
    }
    emit(RecordingCompletedState(_controller));
  }

  Future<XFile?> _stoppedRecording() async {
    if (_controller == null || !_controller!.value.isRecordingVideo) {
      return null;
    }
    try {
      XFile file = await _controller!.stopVideoRecording();
      //to stop timer
      _tickerSubscription?.cancel();
      debugPrint("--- Event :- _stoppedRecording :: CurrentState :- $state");
      return file;
    } on CameraException catch (e) {
      //will set state to ErrorInCameraState state
      return null;
    }
  }

  Future<void> _disposeCamera(
      DisposeCameraEvent event, Emitter<RecordResponseState> emit) async {
    if (_controller != null) {
      await _controller?.dispose();
      debugPrint("--- Event :- _disposeCamera :: CurrentState :- $state");
      debugPrint("Camera Disposed");
    }
    _tickerSubscription?.cancel();
    emit(const CameraDisposedState(null));
  }
}
