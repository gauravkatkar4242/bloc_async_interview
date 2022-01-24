import 'package:bloc_async_interview/screen%20size/screen_size_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:universal_html/html.dart" as html;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var maxHeight = 0.0;
  var maxWidth = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("didChangeDependencies called");
    context.read<ScreenSizeCubit>().disableFullScreen();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxHeight > maxHeight ||
            constraints.maxWidth > maxWidth) {
          maxHeight = constraints.maxHeight;
          maxWidth = constraints.maxWidth;
          debugPrint("If called $maxHeight  $maxWidth");
        } else if (constraints.maxHeight == maxHeight &&
            constraints.maxWidth == maxWidth) {
          debugPrint('Equal');
        } else {
          debugPrint("ELse called");
          context.read<ScreenSizeCubit>().disableFullScreen();
        }
        return BlocBuilder<ScreenSizeCubit, ScreenSizeState>(
          builder: (context, state) {
            if (state is FullScreenState) {
              return Scaffold(
                body: Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            '/cameraTestingPage',
                          );
                        },
                        child: const Text("Test Camera"))),
              );
            } else if (state is NotFullScreenState) {
              return Center(
                child: ElevatedButton(
                  child: const Text('Make Full Screen'),
                  onPressed: () {
                    html.document.documentElement?.requestFullscreen();
                    context.read<ScreenSizeCubit>().enableFullScreen();
                  },
                ),
              );
            }
            return (const Text("No State for Screen Size"));
          },
        );
      }),
    );
  }
}
