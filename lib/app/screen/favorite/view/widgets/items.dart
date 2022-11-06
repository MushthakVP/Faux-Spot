import 'package:cached_network_image/cached_network_image.dart';
import 'package:faux_spot/app/screen/home/view_model/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_helper.dart';
import '../../../../core/colors.dart';
import '../../model/wishlist_model.dart';

class FavoriteItems extends StatelessWidget {
  final FavoriteData data;
  const FavoriteItems({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = context.read<HomeProvider>();
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: whiteColor,
        boxShadow: const [
          BoxShadow(
            color: lightGreyColor,
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
        ],
      ),
      height: 200,
      width: 200,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: data.turfImages!.turfImages1!,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 140,
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
              space5,
              turfCategory(provider),
              Expanded(
                child: Text(
                  data.turfName!,
                  maxLines: 1,
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 6,
            top: 6,
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: lightGreyColor.withOpacity(.5),
                radius: 14,
                child: const Iconify(
                  AntDesign.delete,
                  color: redColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Wrap turfCategory(HomeProvider provider) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 3,
      children: [
        Visibility(
          visible: data.turfCategory!.turfFootball!,
          child: Iconify(
            provider.categoryList[0].icon,
            size: 16,
          ),
        ),
        Visibility(
          visible: data.turfCategory!.turfYoga!,
          child: Iconify(
            provider.categoryList[1].icon,
            size: 16,
          ),
        ),
        Visibility(
          visible: data.turfCategory!.turfCricket!,
          child: Iconify(
            provider.categoryList[2].icon,
            size: 16,
          ),
        ),
        Visibility(
          visible: data.turfCategory!.turfBadminton!,
          child: Iconify(
            provider.categoryList[3].icon,
            size: 16,
          ),
        ),
      ],
    );
  }

  CachedNetworkImage sliderWidget({required String image}) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
