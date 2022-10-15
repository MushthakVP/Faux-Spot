import 'package:faux_spot/app/routes/routes.dart';
import 'package:faux_spot/app/screen/home/view/widget/category_widget.dart';
import 'package:faux_spot/app/screen/home/view/widget/list_items.dart';
import 'package:faux_spot/app/screen/home/view_model/home_provider.dart';
import 'package:faux_spot/app/screen/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../overview/view/overview.dart';
import '../service/location.dart';
import 'widget/custom_appbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    GetUserLoction location = context.read<GetUserLoction>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      location.getUserLocation();
    });
    GetUserLoction locationProvider = context.read<GetUserLoction>();
    HomeProvider provider = context.read<HomeProvider>();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(105),
        child: CustomAppBAr(),
      ),
      body: Column(
        children: [
          const CategoryWidget(),
          Selector<HomeProvider, bool>(
            selector: (context, obj) => obj.initSearching,
            builder: (context, loading, _) {
              return provider.searchList.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                        itemCount: provider.searchList.length,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final data = provider.searchList[index];
                          return GestureDetector(
                            onTap: () {
                              Routes.push(screen: OverView(data: data));
                            },
                            child: HomeScreenItems(data: data),
                          );
                        },
                      ),
                    )
                  : items(locationProvider);
            },
          ),
        ],
      ),
    );
  }

  Expanded items(GetUserLoction locationProvider) {
    return Expanded(
      child: Selector<GetUserLoction, bool>(
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
                    childAspectRatio: 1,
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
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final data = locationProvider.turfList[index];
                        return GestureDetector(
                          onTap: () {
                            Routes.push(screen: OverView(data: data));
                          },
                          child: HomeScreenItems(data: data),
                        );
                      },
                    );
        },
      ),
    );
  }
}
