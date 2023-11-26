import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:znotes/pages/home_page.dart';

import 'bloc/notes_bloc.dart';
import 'injection_container.dart';
import 'repositories/notes_repository.dart';

void main() {
  setup();
  runApp(
    BlocProvider(
      create: (context) => NotesBloc(getIt<NotesRepository>()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZNotes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlutterSplashScreen.scale(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.lightBlue,
            Colors.blue,
          ],
        ),
        childWidget: SizedBox(
          height: 90,
          child: Image.asset("lib/assets/logo.png"),
        ),
        duration: const Duration(milliseconds: 1500),
        animationDuration: const Duration(milliseconds: 1000),
        onAnimationEnd: () => debugPrint("On Scale End"),
        nextScreen: DefaultTabController(
          length: 3,
          child: MyHomePage(),
        ),
      ),
    );
  }
}
