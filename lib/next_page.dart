import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        var maxHeight = constraints.maxHeight;
        var maxWidth = constraints.maxWidth;
        return Center(
          child: Container(
            constraints: BoxConstraints.expand(),
            color: Colors.blueGrey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Question Will be displayed here"),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/recordResponsePage',
                        );
                      },
                      child: const Text("Start Answering"))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
