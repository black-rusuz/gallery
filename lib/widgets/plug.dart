import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pictures/bloc/photo_bloc.dart';
import 'package:provider/src/provider.dart';

import '../constants.dart';

class Plug extends StatelessWidget {
  const Plug({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  context.read<PhotoBloc>().add(PhotoRefreshed());
                },
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: SvgPicture.asset(
                        Constants.connectionErrorImage,
                        width: 160.0,
                        height: 160.0,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        Constants.connectionErrorTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Constants.colorTitle,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      Constants.connectionErrorMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Constants.colorSubtitle,
                        fontSize: 12.0,
                        height: 2.0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
    return RefreshIndicator(
      onRefresh: () async {
        context.read<PhotoBloc>().add(PhotoRefreshed());
      },
      child: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: SvgPicture.asset(
                    Constants.connectionErrorImage,
                    width: 160.0,
                    height: 160.0,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    Constants.connectionErrorTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Constants.colorTitle,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text(
                  Constants.connectionErrorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Constants.colorSubtitle,
                    fontSize: 12.0,
                    height: 2.0,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
