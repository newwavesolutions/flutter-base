import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'detail_movie_photo_view_cubit.dart';

class DetailMoviePhotoViewArguments {
  List<String> images;

  DetailMoviePhotoViewArguments({
    required this.images,
  });
}

class DetailMoviePhotoViewPage extends StatelessWidget {
  final DetailMoviePhotoViewArguments arguments;

  const DetailMoviePhotoViewPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return DetailMoviePhotoViewCubit();
      },
      child: DetailMoviePhotoViewChildPage(
        images: arguments.images,
      ),
    );
  }
}

class DetailMoviePhotoViewChildPage extends StatefulWidget {
  final List<String> images;

  const DetailMoviePhotoViewChildPage({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<DetailMoviePhotoViewChildPage> createState() =>
      _DetailMoviePhotoViewChildPageState();
}

class _DetailMoviePhotoViewChildPageState
    extends State<DetailMoviePhotoViewChildPage> {
  late final DetailMoviePhotoViewCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Stack(children: [
      PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(widget.images[index]),
          );
        },
        itemCount: widget.images.length,
      ),
      Positioned(
        top: 40,
        right: 20,
        child: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      )
    ]);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
