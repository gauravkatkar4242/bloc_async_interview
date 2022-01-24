import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return Center(
            child: Container(
              constraints: const BoxConstraints.expand(),
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
      ),
    );
  }
}
