import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/photo_bloc.dart';
import 'widgets/photo_grid.dart';
import 'widgets/widgets.dart';
import 'constants.dart';
import 'simple_bloc_observer.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = SimpleBlocObserver(); // TODO: Убрать
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

class _HomeState extends State<Home> with TickerProviderStateMixin {
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
    List<Widget> _homeFragments = <Widget>[
      // TODO: Фильтры игнорируются
      BlocProvider(
          create: (_) => PhotoBloc(
            httpClient: http.Client(),
            isNew: true,
          )..add(PhotoFetched()),
          child: PhotoGrid()),
      BlocProvider(
          create: (_) => PhotoBloc(
                httpClient: http.Client(),
                isPopular: true,
              )..add(PhotoFetched()),
          child: PhotoGrid())
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBars.elementAt(_mainIndex),
      body: _homeFragments.elementAt(_mainIndex),
      bottomNavigationBar: Widgets.navBar(_mainIndex, _onBottomItemTap),
    );
  }
}
