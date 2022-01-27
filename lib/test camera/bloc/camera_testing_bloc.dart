import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../timer.dart';

part 'camera_testing_event.dart';

part 'camera_testing_state.dart';

class CameraTestingBloc extends Bloc<CameraTestingEvent, CameraTestingState> {
  CameraController? _controller;
  final CountDownTimer _ticker = const CountDownTimer();
  StreamSubscription<int>? _tickerSubscription;

  CameraTestingBloc() : super(const CameraInitializingState(null)) {
    on<InitCameraEvent>(_initCamera);
    on<StartRecordingEvent>(_startRecording);
    on<TimerTickedEvent>(_timerTicked);
    on<StopRecordingEvent>(_getRecordedVideo);
    on<DisposeCameraEvent>(_disposeCamera);
  }

  Future<void> _initCamera(
      InitCameraEvent event, Emitter<CameraTestingState> emit) async {
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
      emit(CameraReadyState(_controller));
    } on CameraException catch (e) {
      emit(const ErrorInCameraState(null));
    }
  }

  Future<void> _startRecording(
      StartRecordingEvent event, Emitter<CameraTestingState> emit) async {
    // _controller.startVideoRecording()
    debugPrint("--- Event :- _startRecording :: CurrentState :- $state");

    if (_controller == null || _controller!.value.isRecordingVideo) {
      return;
    }
    try {
      await _controller!.startVideoRecording();

      emit(RecordingInProgressState(_controller, 10));

      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker
          .tick(ticks: 10)
          .listen((duration) => add(TimerTickedEvent(duration: duration)));
    } on CameraException catch (e) {
      //will set state to CameraExceptionState state
      emit(ErrorInCameraState(_controller));
    }
  }

  void _timerTicked(TimerTickedEvent event, Emitter<CameraTestingState> emit) {
    debugPrint("_timerTicked ${event.duration}");
    if (event.duration == 0) {
      add(StopRecordingEvent());
    } else {
      emit(RecordingInProgressState(_controller, event.duration));
    }
  }

  Future<void> _getRecordedVideo(
      StopRecordingEvent event, Emitter<CameraTestingState> emit) async {
    XFile? file = await _stoppedRecording();
    if (file == null) {
      emit(ErrorInCameraState(_controller));
      return;
    }
    var url = file.path;

    emit(RecordingCompletedState(_controller, url));
     file.saveTo("abd.mp4");
    // logic for saving and uploading video

    emit(CameraReadyState(_controller));
  }

  Future<XFile?> _stoppedRecording() async {
    if (_controller == null || !_controller!.value.isRecordingVideo) {
      //will set state to CameraExceptionState state - Null video
      return null;
    }
    try {
      XFile file = await _controller!.stopVideoRecording();
      _tickerSubscription?.cancel();
      debugPrint("--- Event :- _stoppedRecording :: CurrentState :- $state");
      return file;
    } on CameraException catch (e) {
      //will set state to CameraExceptionState state
      return null;
    }
  }

  Future<void> _disposeCamera(
      DisposeCameraEvent event, Emitter<CameraTestingState> emit) async {
    debugPrint("--- Event :- _disposeCamera :: CurrentState :- $state");

    emit(const CameraDisposedState(null));

    if (_controller != null) {
      await _controller?.dispose();
      debugPrint("Camera Disposed");
    }
    _tickerSubscription?.cancel();
  }
}
