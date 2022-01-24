import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'question_part_state.dart';

class QuestionPartCubit extends Cubit<QuestionPartState> {
  int totalQuestions = 5;
  String firstHalf = "";
  String secondHalf = "";
  int index = 1;

  final List<String> _questionList = [
    "Why do you want to leave (or have left) your current job?",
    "Tell me about a time when you received criticism from your manager. How did you react to that criticism? How did you make improvements based on that criticism? Also, Tell me about a time that you naturally took on a leadership role without being asked. Did you enjoy being a leader? Were you happy with the outcome? How did you make improvements based on that criticism?ell me about a time when you received criticism from your manager. How did you react to that criticism? How did you make improvements based on that criticism? Also, Tell me about a time that you naturally took on a leadership role without being asked. Did you enjoy being a leader? Were you happy with the outcome? How did you make improvements based on that criticism?Tell me about a time when you received criticism from your manager. How did you react to that criticism? How did you make improvements based on that criticism? Also, Tell me about a time that you naturally took on a leadership role without being asked. Did you enjoy being a leader? Were you happy with the outcome? How did you make improvements based on that criticism?ell me about a time when you received criticism from your manager. How did you react to that criticism? How did you make improvements based on that criticism? Also, Tell me about a time that you naturally took on a leadership role without being asked. Did you enjoy being a leader? Were you happy with the outcome? How did you make improvements based on that criticism?ell me about a time when you received criticism from your manager. How did you react to that criticism? How did you make improvements based on that criticism? Also, Tell me about a time that you naturally took on a leadership role without being asked. Did you enjoy being a leader? Were you happy with the outcome? How did you make improvements based on that criticism?",
    "Tell me about a time when you received criticism from your manager. How did you react to that criticism? How did you make improvements based on that criticism? Also, Tell me about a time that you naturally took on a leadership role without being asked. Did you enjoy being a leader? Were you happy with the outcome?",
    "What is the difference between hard work and smart work?",
  ];

  QuestionPartCubit() : super(const QuestionPartInitial("", ""));

  void splitQue() {
    if (_questionList[index].length > 65) {
      if (kIsWeb && _questionList[index].length > 200) {
        firstHalf = _questionList[index].substring(0, 200);
        secondHalf =
            _questionList[index].substring(200, _questionList[index].length);
      } else {
        firstHalf = _questionList[index].substring(0, 65);
        secondHalf =
            _questionList[index].substring(65, _questionList[index].length);
      }
    } else {
      firstHalf = _questionList[index];
      secondHalf = "";
      emit(ShortQueState(firstHalf));
      return;
    }
    emit(HalfQueState(firstHalf, secondHalf));
  }

  void showHalfQuestion() {
    emit(HalfQueState(firstHalf, secondHalf));
  }

  void showFullQuestion() {
    emit(FullQueState(firstHalf, secondHalf));
  }
}
