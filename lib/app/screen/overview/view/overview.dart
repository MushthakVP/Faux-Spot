import 'package:cached_network_image/cached_network_image.dart';
import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/screen/home/model/home_model.dart';
import 'package:faux_spot/app/screen/overview/view_model/overview_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class OverView extends StatelessWidget {
  final DataList data;
  const OverView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        SystemChrome.setSystemUIOverlayStyle(
          uiOverlay(status: transparentColor),
        );
        context
            .read<OverViewProvider>()
            .changeAppbarImage(image: data.turfImages!.turfImages1.toString());
      },
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(270),
        child: CustomAppBar(data: data),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          space10,
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final DataList data;
  const CustomAppBar({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Selector<OverViewProvider, String>(
        selector: (context, obj) => obj.appbarImage,
        builder: (context, image, _) {
          return CachedNetworkImage(
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              width: double.infinity,
              height: 270,
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
                  Center(
                    child: Material(
                     color: lightGreyColour.withOpacity(.3),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(4),
                            child: CachedNetworkImage(
                              imageUrl: data.turfImages!.turfImages1.toString(),
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
        });
  }
}
