import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'screen_size_state.dart';

class ScreenSizeCubit extends Cubit<ScreenSizeState> {
  ScreenSizeCubit() : super(NotFullScreenState());

  void enableFullScreen() {
    debugPrint("Enabling Full Screen");
    emit(FullScreenState());
  }

  void disableFullScreen() {
    debugPrint("Disabling Full Screen");
    emit(NotFullScreenState());
  }
}
