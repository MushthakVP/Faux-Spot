import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/routes/routes.dart';
import 'package:faux_spot/app/screen/home/view/widget/list_items.dart';
import 'package:faux_spot/app/screen/home/view_model/home_provider.dart';
import 'package:faux_spot/app/screen/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
                  : items(location, size);
            },
          ),
        ],
      ),
    );
  }

  Expanded items(GetUserLocation locationProvider, Size size) {
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
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: .95,
                  ),
                  itemBuilder: (context, index) {
                    return Shimer.itemShimmer(he: 200, wi: 200);
                  },
                )
              : GridView.builder(
                  itemCount: locationProvider.turfList.length,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .94,
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
