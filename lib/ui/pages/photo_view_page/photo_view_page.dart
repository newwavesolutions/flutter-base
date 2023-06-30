import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'photo_view_cubit.dart';

class PhotoViewArguments {
  List<String> images;

  PhotoViewArguments({
    required this.images,
  });
}

class PhotoViewPage extends StatelessWidget {
  final PhotoViewArguments arguments;

  const PhotoViewPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PhotoViewCubit();
      },
      child: PhotoViewChildPage(
        images: arguments.images,
      ),
    );
  }
}

class PhotoViewChildPage extends StatefulWidget {
  final List<String> images;

  const PhotoViewChildPage({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<PhotoViewChildPage> createState() => _PhotoViewChildPageState();
}

class _PhotoViewChildPageState extends State<PhotoViewChildPage> {
  late final PhotoViewCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
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
            Navigator.of(context).pop();
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
