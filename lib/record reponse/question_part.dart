import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuestionPart extends StatefulWidget {
  const QuestionPart({Key? key}) : super(key: key);
  final int index = 1;
  // final int index = 2;

  @override
  _QuestionPartState createState() => _QuestionPartState();
}

class _QuestionPartState extends State<QuestionPart> {
  int totalQuestions = 5;
  String firstHalf = "";
  String secondHalf = "";
  bool flag = true;

  final List<String> _questionList = [
    "Why do you want to leave (or have left) your current job?",
    "Tell me about a time when you received criticism from your manager. How did you react to that criticism? How did you make improvements based on that criticism? Also, Tell me about a time that you naturally took on a leadership role without being asked. Did you enjoy being a leader? Were you happy with the outcome? How did you make improvements based on that criticism?",
    "What is the difference between hard work and smart work?",
  ];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
    if (_questionList[widget.index].length > 65) {
      if (kIsWeb && _questionList[widget.index].length > 200) {
        firstHalf = _questionList[widget.index].substring(0, 200);
        secondHalf = _questionList[widget.index]
            .substring(200, _questionList[widget.index].length);
      } else {
        firstHalf = _questionList[widget.index].substring(0, 65);
        secondHalf = _questionList[widget.index]
            .substring(65, _questionList[widget.index].length);
      }
    } else {
      firstHalf = _questionList[widget.index];
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        // padding: EdgeInsets.symmetric(vertical: kIsWeb ? 20 : 10 , horizontal: 20),
        padding: EdgeInsets.only(top: kIsWeb ? 20 : 10,
            bottom: kIsWeb ? 20 : 0,
            left: 20,
            right: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${widget.index + 1} of $totalQuestions",
              style: const TextStyle(
                  fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: kIsWeb ? 10 : 5,),
            secondHalf.isEmpty
                ? Text(
                    firstHalf,
                    style: const TextStyle(color: Colors.black45, fontSize: 16),
                  )
                : Column(
                    children: <Widget>[
                      Text(
                        flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                        // textAlign: TextAlign.left,
                        style: const TextStyle(color: Colors.black45, fontSize: 16),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          child: Text(
                            flag ? "Show more" : "Show less",
                            style: const TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.left,
                          ),
                          onPressed: () {
                            setState(() {
                              flag = !flag;
                            });
                          },
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
