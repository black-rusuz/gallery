import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery/bloc/photo_bloc.dart';
import 'package:gallery/constants.dart';
import 'package:provider/src/provider.dart';

class Plug extends StatelessWidget {
  Plug({Key? key}) : super(key: key);
  Completer _refreshCompleter = Completer<void>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhotoBloc, PhotoState>(
      listener: (context, state) {
        if (state is PhotoSuccess || state is PhotoError) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
        }
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              context.read<PhotoBloc>().add(PhotoRefreshed());
              return _refreshCompleter.future;
            },
          ),
          SliverFillRemaining(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                ]),
          ),
        ],
      ),
    );
  }
}
