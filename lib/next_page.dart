import 'package:bloc_async_interview/test%20camera/camera_testing_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("This is Next Page"),
        ElevatedButton(onPressed: (){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CameraTestingPage(),
              ));
        }, child: const Text("Test Camera"))
      ],
    );
  }
}
