import 'package:flutter/material.dart';
import '/constants.dart';
import '/presentation/home.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: ThemeData(
        primarySwatch: Constants.colorAccent,
      ),
      home: const Home(),
    );
  }
}
