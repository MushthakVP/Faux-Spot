import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/routes/routes.dart';
import 'package:faux_spot/app/screen/home/view/widget/custom_appbar.dart';
import 'package:faux_spot/app/screen/home/view/widget/list_items.dart';
import 'package:faux_spot/app/screen/home/view_model/home_provider.dart';
import 'package:faux_spot/app/screen/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/images.dart';
import '../../overview/view/overview.dart';
import '../service/location.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    GetUserLocation location = context.read<GetUserLocation>();
    location.userDistrict == null ? location.getUserLocation() : null;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    HomeProvider provider = context.read<HomeProvider>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Selector<HomeProvider, bool>(
          selector: (context, provider) => provider.search,
          builder: (context, search, _) {
            return !search
                ? AppBar(
                    toolbarHeight: 70,
                    systemOverlayStyle:
                        uiOverlay(status: primaryColor, navigate: whiteColor),
                    backgroundColor: primaryColor,
                    elevation: 0,
                    title: appBarWid(size),
                    actions: [
                      Visibility(
                        visible:
                            context.watch<HomeProvider>().searchList.isNotEmpty,
                        child: IconButton(
                          splashRadius: 25,
                          icon: const Icon(
                            Icons.search,
                            color: whiteColor,
                          ),
                          onPressed: () {
                            provider.searchValueChange(true);
                          },
                        ),
                      ),
                    ],
                  )
                : const CustomSearchWidget();
          },
        ),
      ),
      body: Consumer<GetUserLocation>(
        builder: (context, value, _) {
          return value.turfListLoading
              ? GridView.builder(
                  itemCount: 8,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: .95,
                  ),
                  itemBuilder: (context, index) {
                    return Shimer.itemShimmer(he: 200, wi: 200);
                  },
                )
              : Consumer<HomeProvider>(
                  builder: (context, obj, _) {
                    return obj.searchList.isNotEmpty
                        ? GridView.builder(
                            itemCount: value.turfList.length,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 0,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: .94,
                            ),
                            itemBuilder: (context, index) {
                              final data = obj.searchList[index];
                              return GestureDetector(
                                onTap: () {
                                  Routes.push(screen: OverView(data: data));
                                },
                                child:
                                    HomeScreenItems(data: data, index: index),
                              );
                            },
                          )
                        : value.turfList.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      loginImage,
                                      height: 150,
                                    ),
                                  ),
                                  space30,
                                  const Text(
                                      "we are expanding soon in your area"),
                                ],
                              )
                            : GridView.builder(
                                itemCount: value.turfList.length,
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 0,
                                ),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: .94,
                                ),
                                itemBuilder: (context, index) {
                                  final data = value.turfList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Routes.push(screen: OverView(data: data));
                                    },
                                    child: HomeScreenItems(
                                        data: data, index: index),
                                  );
                                },
                              );
                  },
                );
        },
      ),
    );
  }

  Consumer<GetUserLocation> appBarWid(Size size) {
    return Consumer<GetUserLocation>(
      builder: (context, value, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                value.isLoading
                    ? Shimmer.fromColors(
                        baseColor: primaryColor,
                        highlightColor: lightGreyColor.withOpacity(.1),
                        child: SizedBox(
                          width: size.width * 0.4,
                          height: 22,
                          child: Material(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Near by',
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              const Iconify(
                                Carbon.location,
                                color: whiteColor,
                                size: 16,
                              ),
                              space5,
                              Text(
                                value.userLocation == null
                                    ? 'Location'
                                    : value.userLocation.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ],
            ),
          ],
        );
      },
    );
  }
}
