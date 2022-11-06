import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

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
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        placeholder: (context, url) => const SizedBox(
          height: 70,
          width: 70,
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
      ),
    );
  }
}
