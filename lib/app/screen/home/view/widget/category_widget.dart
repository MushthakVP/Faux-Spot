import 'package:faux_spot/app/screen/home/service/location.dart';
import 'package:faux_spot/app/screen/home/view_model/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/app_helper.dart';
import '../../../../core/colors.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = context.read<HomeProvider>();
    return LimitedBox(
      maxHeight: 60,
      child: ListView.builder(
        itemCount: provider.categoryList.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final listData = provider.categoryList[index];
          return Selector<GetUserLoction, bool>(
            selector: (context, obj) => obj.turfListLoading,
            builder: (context, loading, child) {
              return loading
                  ? Shimmer.fromColors(
                     baseColor: Colors.grey.shade300,
                highlightColor: blackColour.withOpacity(.4),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        height: 40,
                        width: listData.width,
                        child:  Material(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      height: 40,
                      width: listData.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: AssetImage(listData.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          space10,
                          Iconify(
                            listData.icon,
                            color: whiteColour,
                          ),
                          const Spacer(),
                          Text(
                            listData.name,
                            style: const TextStyle(
                              color: whiteColour,
                              fontSize: 20,
                            ),
                          ),
                          space20
                        ],
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
