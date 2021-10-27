import 'package:flutter/material.dart';
import 'package:pictures/widgets.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      theme: ThemeData(
        primarySwatch: Constants.COLOR_ACCENT,
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
  // TODO: Следить за нулём
  int _selectedIndex = 0;

  // TODO: Подумать над баром с кнопкой "назад"
  static List<AppBar> get _appBars => <AppBar>[
    Widgets.appBar(Constants.TITLE_NEW),
    Widgets.appBar(Constants.TITLE_POPULAR),
  ];


  // TODO: Начать с этого и дальше по тудушкам
  List<Widgets> images = <Widgets>[];
  void getImagesList(){
    for (int i = 0; i < 10; i++) {
      print(i);
    };
  }

  // TODO: Доработать, подключить к API
  static final List<Widget> _homeFragments = <Widget>[
    Widgets.mainGrid(),
    Widgets.plug(),
  ];

  void _onItemTapped(int index) { setState(() { _selectedIndex = index; }); }

  @override
  Widget build(BuildContext context) {
    getImagesList();
    return Scaffold(
      // TODO: Заменить на белый
      backgroundColor: Colors.white70,

      appBar: _appBars.elementAt(_selectedIndex),
      body: _homeFragments.elementAt(_selectedIndex),
      bottomNavigationBar: Widgets.navBar(_selectedIndex, _onItemTapped),
    );
  }
}
