import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart';
import 'simple_bloc_observer.dart';
import 'bloc/photo_bloc.dart';
import 'widgets/photo_grid.dart';
import 'widgets/widgets.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _mainIndex = 0;

  final List<AppBar> _appBars = <AppBar>[
    Widgets.appBar(Constants.titleNew),
    Widgets.appBar(Constants.titlePopular),
  ];

  void _onBottomItemTap(int index) {
    setState(() {
      _mainIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _homeFragments = <Widget>[
      BlocProvider(
        key: UniqueKey(),
        create: (context) => PhotoBloc(isNew: true)..add(PhotoFetched()),
        child: const PhotoGrid(),
      ),
      BlocProvider(
        key: UniqueKey(),
        create: (context) => PhotoBloc(isPopular: true)..add(PhotoFetched()),
        child: const PhotoGrid(),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBars.elementAt(_mainIndex),
      body: _homeFragments.elementAt(_mainIndex),
      bottomNavigationBar: Widgets.navBar(_mainIndex, _onBottomItemTap),
    );
  }
}
