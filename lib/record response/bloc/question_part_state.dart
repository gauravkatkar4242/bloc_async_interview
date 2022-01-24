part of 'question_part_cubit.dart';

abstract class QuestionPartState extends Equatable {
  final String firstHalf;
  final String secondHalf;

  const QuestionPartState(this.firstHalf, this.secondHalf);

  @override
  List<Object> get props => [firstHalf, secondHalf];
}

class QuestionPartInitial extends QuestionPartState {
  const QuestionPartInitial(String firstHalf, String secondHalf)
      : super(firstHalf, secondHalf);
}

class ShortQueState extends QuestionPartState {
  const ShortQueState(String firstHalf) : super(firstHalf, "");
}

class HalfQueState extends QuestionPartState {
  const HalfQueState(String firstHalf, String secondHalf)
      : super(firstHalf, secondHalf);
}

class FullQueState extends QuestionPartState {
  const FullQueState(String firstHalf, String secondHalf)
      : super(firstHalf, secondHalf);
}
