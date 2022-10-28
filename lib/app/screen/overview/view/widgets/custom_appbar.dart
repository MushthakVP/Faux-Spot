import 'package:cached_network_image/cached_network_image.dart';
import 'package:faux_spot/app/routes/routes.dart';
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
    Size size = MediaQuery.of(context).size;
    OverViewProvider provider = context.read<OverViewProvider>();
    return Selector<OverViewProvider, String>(
      selector: (context, obj) => obj.appbarImage,
      builder: (context, image, _) {
        return CachedNetworkImage(
          imageUrl: image,
          imageBuilder: (context, imageProvider) => Container(
            width: double.infinity,
            height: size.width / 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: size.height * 0.05),
                    Row(
                      children: [
                        space10,
                        GestureDetector(
                          onTap: () {
                            Routes.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: lightGreyColor.withOpacity(.4),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_back),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    appSmallImage(provider),
                    space10,
                  ],
                ),
              ],
            ),
          ),
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: whiteColor,
            highlightColor: greyColor,
            child: SizedBox(
              height: size.width / 1.5,
              width: double.infinity,
              child: const Material(),
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
      width: 240,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: lightGreyColor.withOpacity(.7),
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
