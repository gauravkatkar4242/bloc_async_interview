part of 'question_part_cubit.dart';

abstract class QuestionPartState extends Equatable {
  final String firstHalf;
  final String secondHalf;
  const QuestionPartState(this.firstHalf, this.secondHalf);
  @override
  List<Object> get props => [];
}

class QuestionPartInitial extends QuestionPartState {
  QuestionPartInitial(String firstHalf, String secondHalf) : super(firstHalf, secondHalf);
}

class ShortQueState extends QuestionPartState{
  ShortQueState(String firstHalf) : super(firstHalf, "");

}
class HalfQueState extends QuestionPartState{
  HalfQueState(String firstHalf, String secondHalf) : super(firstHalf, secondHalf);
}
class FullQueState extends QuestionPartState{
  FullQueState(String firstHalf, String secondHalf) : super(firstHalf, secondHalf);
}

