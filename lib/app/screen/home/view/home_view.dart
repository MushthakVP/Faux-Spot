import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/routes/routes.dart';
import 'package:faux_spot/app/screen/home/view/widget/list_items.dart';
import 'package:faux_spot/app/screen/home/view_model/home_provider.dart';
import 'package:faux_spot/app/screen/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import '../../overview/view/overview.dart';
import '../service/location.dart';
import 'widget/custom_appbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    GetUserLocation location = context.read<GetUserLocation>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(
          uiOverlay(status: primaryColor, navigate: whiteColor));
      location.userDistrict == null ? location.getUserLocation() : null;
      location.getHomeData("Malappuram");
    });
    HomeProvider provider = context.read<HomeProvider>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.width * 0.28),
        child: const CustomAppBAr(),
      ),
      body: Column(
        children: [
          Selector<HomeProvider, bool>(
            selector: (context, obj) => obj.initSearching,
            builder: (context, loading, _) {
              return provider.searchList.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                        controller: provider.scrollController,
                        itemCount: provider.searchList.length,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .95,
                        ),
                        itemBuilder: (context, index) {
                          final data = provider.searchList[index];
                          return GestureDetector(
                            onTap: () {
                              Routes.push(screen: OverView(data: data));
                            },
                            child: HomeScreenItems(data: data, index: index),
                          );
                        },
                      ),
                    )
                  : items(location);
            },
          ),
        ],
      ),
      bottomNavigationBar: Selector<HomeProvider, int>(
          selector: (context, obj) => obj.index,
          builder: (context, index, _) {
            return WaterDropNavBar(
              backgroundColor: Colors.white,
              onItemSelected: (value) {
                provider.changeBottomIndex(index: value);
              },
              waterDropColor: primaryColor,
              selectedIndex: index,
              barItems: [
                BarItem(
                  filledIcon: Icons.home,
                  outlinedIcon: Icons.home_outlined,
                ),
                BarItem(
                  filledIcon: Icons.bookmark_rounded,
                  outlinedIcon: Icons.bookmark_border_rounded,
                ),
                BarItem(
                  filledIcon: Icons.settings,
                  outlinedIcon: Icons.settings_outlined,
                ),
              ],
            );
          }),
    );
  }

  Expanded items(GetUserLocation locationProvider) {
    return Expanded(
      child: Selector<GetUserLocation, bool>(
        selector: (context, obj) => obj.turfListLoading,
        builder: (context, turfListLoading, _) {
          return turfListLoading
              ? GridView.builder(
                  itemCount: 8,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .95,
                  ),
                  itemBuilder: (context, index) {
                    return Shimer.itemShimmer(he: 200, wi: 200);
                  },
                )
              : locationProvider.turfList.isEmpty
                  ? const Text("No Nearest Turf")
                  : GridView.builder(
                      itemCount: locationProvider.turfList.length,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .95,
                      ),
                      itemBuilder: (context, index) {
                        final data = locationProvider.turfList[index];
                        return GestureDetector(
                          onTap: () {
                            Routes.push(screen: OverView(data: data));
                          },
                          child: HomeScreenItems(data: data, index: index),
                        );
                      },
                    );
        },
      ),
    );
  }
}
