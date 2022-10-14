import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/eva.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/app_helper.dart';
import '../../../../core/colors.dart';
import '../../service/location.dart';

class CustomAppBAr extends StatelessWidget {
  const CustomAppBAr({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(uiOverlay(
        status: primaryColor,
        brightness: Brightness.light,
      ));
    });

    return Container(
      color: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Consumer<GetUserLoction>(builder: (context, value, _) {
            return Row(
              children: [
                !value.isLoaidng  ? space20 : space10,
                Visibility(
                  visible: !value.isLoaidng,
                  child: const Iconify(
                    Carbon.location,
                    color: whiteColour,
                    size: 16,
                  ),
                ),
                space10,
                value.isLoaidng
                    ? Shimmer.fromColors(
                        baseColor: primaryColor,
                        highlightColor: lightGreyColour,
                        child: SizedBox(
                          width: 130,
                          height: 22,
                          child: Material(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      )
                    : Text(
                        value.userLocation.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: whiteColour,
                        ),
                      ),
                Visibility(
                  visible: !value.isLoaidng,
                  child: const Iconify(
                    Eva.arrow_down_outline,
                    color: lightGreyColour,
                    size: 20,
                  ),
                ),
                const Spacer(),
              ],
            );
          }),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: lightGreyColour,
                    ),
                  ),
                  child: const Center(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.1,
                        color: Colors.white,
                        letterSpacing: .8,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          height: .9,
                          color: lightGreyColour,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.notifications,
                        color: whiteColour,
                      ),
                    ],
                  ),
                  Positioned(
                    top: -10,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '5',
                        style: TextStyle(fontSize: 10, color: whiteColour),
                      ),
                    ),
                  )
                ],
              ),
              space15,
            ],
          ),
        ],
      ),
    );
  }
}
