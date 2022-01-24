part of 'screen_size_cubit.dart';

abstract class ScreenSizeState extends Equatable {
  const ScreenSizeState();

  @override
  List<Object> get props => [];
}

class FullScreenState extends ScreenSizeState {}

class NotFullScreenState extends ScreenSizeState {}
