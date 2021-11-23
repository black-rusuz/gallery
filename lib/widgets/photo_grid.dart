import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pictures/bloc/photo_bloc.dart';
import 'package:pictures/constants.dart';
import 'package:pictures/widgets/photo_grid_item.dart';

import 'plug.dart';

class PhotoGrid extends StatefulWidget {
  const PhotoGrid({Key? key}) : super(key: key);

  @override
  _PhotoGridState createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  final _scrollController = ScrollController();

  Completer completer = Completer();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoBloc, PhotoState>(
      builder: (context, state) {
        if (state is PhotoError) {
          return const Plug();
        }
        if (state is PhotoSuccess) {
          return CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 3));
                },
                refreshTriggerPullDistance: 100,
                refreshIndicatorExtent: 60,
                builder: (context, mode, _, __, ___) {
                  return const CupertinoActivityIndicator();
                },
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return PhotoGridItem(photo: state.photos[index]);
                    },
                    childCount: state.photos.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 160 / 100,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                ),
              ),
              if (!state.hasReachedMax)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child:
                        Center(child: CupertinoActivityIndicator(radius: 15)),
                  ),
                ),
            ],
          );
          return GridView.builder(
            controller: _scrollController,
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 160 / 100,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            // TODO: Сделать индикатор по центру?
            itemBuilder: (BuildContext context, int index) {
              return index >= state.photos.length
                  ? const Center(child: CircularProgressIndicator())
                  : PhotoGridItem(photo: state.photos[index]);
            },
            itemCount: state.hasReachedMax
                ? state.photos.length
                : state.photos.length + 1,
          );
        }
        return const SizedBox();
        // return Widgets.plug();
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PhotoBloc>().add(PhotoFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
