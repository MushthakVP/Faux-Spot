import 'package:faux_spot/app/screen/home/view_model/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
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
        navigate: whiteColor,
        brightness: Brightness.light,
      ));
    });
    Size size = MediaQuery.of(context).size;
    HomeProvider provider = context.read<HomeProvider>();
    return Container(
      color: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.05),
          Consumer<GetUserLocation>(
            builder: (context, value, _) {
              return Row(
                children: [
                  !value.isLoading ? space20 : space10,
                  Visibility(
                    visible: !value.isLoading,
                    child: const Iconify(
                      Carbon.location,
                      color: whiteColor,
                      size: 16,
                    ),
                  ),
                  space10,
                  value.isLoading
                      ? Shimmer.fromColors(
                          baseColor: primaryColor,
                          highlightColor: lightGreyColor.withOpacity(.2),
                          child: SizedBox(
                            width: size.width * 0.5,
                            height: 22,
                            child: Material(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        )
                      : Text(
                          value.userLocation == null
                              ? 'Location'
                              : value.userLocation.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: whiteColor,
                          ),
                        ),
                  const Spacer(),
                ],
              );
            },
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    left: 8,
                  ),
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: lightGreyColor,
                    ),
                  ),
                  child: Center(
                    child: TextField(
                      controller: provider.searchController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          provider.suffixButton(
                              suffixIcon: true, context: context);
                        } else {
                          provider.suffixButton(
                              suffixIcon: false, context: context);
                        }
                        provider.searchFilter(context: context, query: value);
                      },
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.1,
                        color: Colors.white,
                        letterSpacing: .8,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: Selector<HomeProvider, bool>(
                          selector: (context, obj) => obj.suffixIcon,
                          builder: (context, icon, child) {
                            return Visibility(
                              visible: icon,
                              child: IconButton(
                                onPressed: () {
                                  provider.suffixButton(
                                      suffixIcon: !icon, context: context);
                                },
                                icon: const Center(
                                  child: Icon(
                                    Icons.close_sharp,
                                    color: whiteColor,
                                    textDirection: TextDirection.ltr,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                          height: .8,
                          color: lightGreyColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              space15,
            ],
          ),
        ],
      ),
    );
  }
}
