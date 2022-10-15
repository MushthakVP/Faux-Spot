import 'package:cached_network_image/cached_network_image.dart';
import 'package:faux_spot/app/screen/overview/view/widgets/small_imageappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/app_helper.dart';
import '../../../../core/colors.dart';
import '../../../home/model/home_model.dart';
import '../../view_model/overview_provider.dart';

class CustomAppBar extends StatelessWidget {
  final DataList data;
  const CustomAppBar({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    OverViewProvider provider = context.read<OverViewProvider>();
    return Selector<OverViewProvider, String>(
      selector: (context, obj) => obj.appbarImage,
      builder: (context, image, _) {
        return CachedNetworkImage(
          imageUrl: image,
          imageBuilder: (context, imageProvider) => Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                appSmallImage(provider),
                space10,
              ],
            ),
          ),
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: lightGreyColour,
            highlightColor: greyColour,
            child: const SizedBox(
              height: 270,
              width: double.infinity,
              child: Material(),
            ),
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.error),
          ),
        );
      },
    );
  }

  SizedBox appSmallImage(OverViewProvider provider) {
    return SizedBox(
      width: 270,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: lightGreyColour.withOpacity(.7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                provider.changeAppbarImage(
                  image: data.turfImages!.turfImages1.toString(),
                );
              },
              child: AppBarSmallImage(
                image: data.turfImages!.turfImages1.toString(),
              ),
            ),
            GestureDetector(
              onTap: () {
                provider.changeAppbarImage(
                  image: data.turfImages!.turfImages2.toString(),
                );
              },
              child: AppBarSmallImage(
                image: data.turfImages!.turfImages2.toString(),
              ),
            ),
            GestureDetector(
              onTap: () {
                provider.changeAppbarImage(
                  image: data.turfImages!.turfImages3.toString(),
                );
              },
              child: AppBarSmallImage(
                image: data.turfImages!.turfImages3.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
