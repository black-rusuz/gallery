import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
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


class _HomeState extends State<Home> with TickerProviderStateMixin{
  int _mainIndex = 0;
  int _page = 1;

  final List<AppBar> _appBars = <AppBar>[
    Widgets.appBar(Constants.TITLE_NEW),
    Widgets.appBar(Constants.TITLE_POPULAR),
  ];

  Future<void> _pullRefresh() async {
    setState(() { _page = 1; });
  }

  void _onImageTap(Photo photo) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: Widgets.backAppBar(),
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
      CustomRefreshIndicator(
        offsetToArmed: 28.0,
        onRefresh: _pullRefresh,
        builder: (BuildContext context, Widget child, IndicatorController controller) {
          return AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, _) {
              return Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  if (!controller.isIdle || controller.isHiding)
                    Positioned(
                      top: controller.value,
                      child: Widgets.loading(this, true),
                    ),
                  Transform.translate(
                    offset: Offset(0, 28.0 * controller.value),
                    child: child,
                  ),
                ],
              );
            },
          );
        },
        child: FutureBuilder(
          future: Widgets.grid(
            Constants.API_REQUEST_NEW + _page.toString(),
            _onImageTap),
          initialData: Widgets.loading(this),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.data;
          },
        ),
      ),
      CustomRefreshIndicator(
        offsetToArmed: 28.0,
        onRefresh: _pullRefresh,
        builder: (BuildContext context, Widget child, IndicatorController controller) {
          return AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, _) {
              return Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  if (!controller.isIdle || controller.isHiding)
                    Positioned(
                      top: controller.value,
                      child: Widgets.loading(this, true),
                    ),
                  Transform.translate(
                    offset: Offset(0, 28.0 * controller.value),
                    child: child,
                  ),
                ],
              );
            },
          );
        },
        child: FutureBuilder(
          future: Widgets.grid(
            Constants.API_REQUEST_POPULAR + _page.toString(),
            _onImageTap),
          initialData: Widgets.loading(this),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.data;
          },
        ),
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
