import 'package:flutter/material.dart';
import 'package:pictures/widgets.dart';
import 'constants.dart';
import 'dto/photo.dart';

void main() { runApp(const MyApp()); }


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


class _HomeState extends State<Home> with TickerProviderStateMixin{
  int _mainIndex = 0;
  int _page = 1;

  final List<AppBar> _appBars = <AppBar>[
    Widgets.appBar(Constants.titleNew),
    Widgets.appBar(Constants.titlePopular),
  ];

  Future<void> _pullRefresh() async {
    setState(() { _page = 1; });
  }

  void _onImageTap(Photo photo) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: Widgets.appBarBack(),
        body: Widgets.details(photo),
      );
    }));
  }

  void _onBottomItemTap(int index) {
    setState(() {
      _mainIndex = index;
      _page++;
    });
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> _homeFragments = <Widget>[
      RefreshIndicator(
        child: FutureBuilder(
          future: Widgets.grid(
              Constants.apiRequestNew + _page.toString(), _onImageTap),
          initialData: Widgets.loading(this),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.data;
          }
        ),
        onRefresh: _pullRefresh),
      RefreshIndicator(
        child: FutureBuilder(
            future: Widgets.grid(
                Constants.apiRequestNew + _page.toString(), _onImageTap),
            initialData: Widgets.loading(this),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.data;
        }
      ),
      onRefresh: _pullRefresh),
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: _appBars.elementAt(_mainIndex),
      body: _homeFragments.elementAt(_mainIndex),
      bottomNavigationBar: Widgets.navBar(_mainIndex, _onBottomItemTap),
    );
  }
}
