import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class CustomBookImage extends StatelessWidget {
  CustomBookImage({Key? key, required this.img}) : super(key: key);
  String img;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.6 / 4,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: CachedNetworkImage(imageUrl: img, fit: BoxFit.cover)),
    );
  }
}
