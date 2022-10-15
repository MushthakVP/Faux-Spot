import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppBarSmallImage extends StatelessWidget {
  final String image;
  const AppBarSmallImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
