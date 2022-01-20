import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'screen_size_state.dart';

class ScreenSizeCubit extends Cubit<ScreenSizeState> {
  ScreenSizeCubit() : super(NotFullScreenState());

  void enableFullScreen(){
    print("Enabling Full Screen");
    emit(FullScreenState());
  }
  void disableFullScreen(){
    print("Disabling Full Screen");
    emit(NotFullScreenState());
  }
}
