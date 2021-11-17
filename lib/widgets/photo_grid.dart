import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:pictures/bloc/photo_bloc.dart';
import 'package:pictures/widgets/photo_grid_item.dart';
import 'package:pictures/widgets/widgets.dart';

class PhotoGrid extends StatefulWidget {
  final bool isNew;
  final bool isPopular;

  const PhotoGrid({Key? key,
    this.isNew = false,
    this.isPopular = false}) : super(key: key);

  @override
  _PhotoGridState createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: BlocProvider(
        create: (_) => PhotoBloc(
            httpClient: http.Client(),
            isNew: widget.isNew,
            isPopular: widget.isPopular)..add(PhotoFetched()),
        child: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            switch (state.status) {
              case PhotoStatus.failure:
                return Widgets.plug();
              case PhotoStatus.success:
                if (state.photos.isEmpty) {
                  return Widgets.plug();
                }
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16.0),
                    child: GridView.builder(
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
                    )
                );
              default:
                return const Center(
                    heightFactor: 1.0,
                    child: CircularProgressIndicator()
                );
            }
          },
        ),
      ),
      // TODO: Прописать pullRequest() (но где?)
      onRefresh: () async { print('hey'); }
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
    // TODO: Починить, скроллКонтроллер вообще не работает
    print('aaaa');
    if (_isBottom) context.read<PhotoBloc>().add(PhotoFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
