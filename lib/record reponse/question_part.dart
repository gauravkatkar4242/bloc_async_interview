import 'dart:ui';

import 'package:bloc_async_interview/record%20reponse/bloc/question_part_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionPart extends StatefulWidget {
  const QuestionPart({Key? key}) : super(key: key);
  final int index = 1;

  // final int index = 0;

  @override
  _QuestionPartState createState() => _QuestionPartState();
}

class _QuestionPartState extends State<QuestionPart> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<QuestionPartCubit>().splitQue();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<QuestionPartCubit, QuestionPartState>(
      builder: (context, state) {
        int totalQuestions = 5;
        String firstHalf =
            context.select((QuestionPartCubit bloc) => bloc.state.firstHalf);
        String secondHalf =
            context.select((QuestionPartCubit bloc) => bloc.state.secondHalf);
        if (state is QuestionPartInitial) {
          return const CircularProgressIndicator();
        }
        return SizedBox(
          height: kIsWeb ? (state is! FullQueState)? height * 0.2 : height * 0.3 : state is! FullQueState? height * 0.16 : height * 0.3,

          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: kIsWeb ? Colors.white : Colors.black,
              padding: kIsWeb ? const EdgeInsets.all(20) : const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Question ${widget.index + 1} of $totalQuestions",
                    style: const TextStyle(
                        fontSize: 18,
                        color: kIsWeb ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: kIsWeb ? 10 : 5,
                  ),
                  if (state is ShortQueState) ...{
                    Text(
                      firstHalf,
                      style: const TextStyle(
                          color: kIsWeb ? Colors.black : Colors.white,
                          fontSize: 16),
                    )
                  },
                  if (state is HalfQueState) ...{
                    Wrap(
                      children: <Widget>[
                        Text(
                          (firstHalf + "..."),
                          style: const TextStyle(
                              color: kIsWeb ? Colors.black : Colors.white,
                              fontSize: 16),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                            ),
                            child: const Text(
                              "Show more",
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              context.read<QuestionPartCubit>().showFullQuestion();
                            },
                          ),
                        ),
                      ],
                    )
                  },
                  if (state is FullQueState) ...{
                    Wrap(
                      children: <Widget>[
                        Text(
                          (firstHalf + secondHalf),
                          // textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: kIsWeb ? Colors.black : Colors.white,
                              fontSize: 16),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                            ),
                            child: const Text(
                              "Show less",
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              context.read<QuestionPartCubit>().showHalfQuestion();
                            },
                          ),
                        ),
                      ],
                    )
                  }
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
