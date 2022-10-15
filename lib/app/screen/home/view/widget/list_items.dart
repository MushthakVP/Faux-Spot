import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_helper.dart';
import '../../../../core/colors.dart';
import '../../model/home_model.dart';

class HomeScreenItems extends StatelessWidget {
  final DataList data;
  const HomeScreenItems({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                    data.turfImages!.turfImages1.toString()),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(
                  right: 6,
                  top: 4,
                  child: Icon(
                    Icons.favorite,
                    color: redColor,
                    size: 20,
                  ),
                ),
                Positioned(
                  bottom: -15,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    child: Center(
                      child: Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.star,
                              color: yellowColor,
                              size: 18,
                            ),
                            Text(
                              data.turfInfo!.turfRating.toString(),
                              style: const TextStyle(
                                color: whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          space15,
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
          )
        ],
      ),
    );
  }
}
