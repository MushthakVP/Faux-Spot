import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/screen/favorite/view/widgets/items.dart';
import 'package:faux_spot/app/screen/favorite/view_model/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/shimmer.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteProvider provider = context.read<FavoriteProvider>();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: uiOverlay(
          status: primaryColor,
          navigate: whiteColor,
          brightness: Brightness.light,
        ),
        title: const Text("Favorite"),
      ),
      body: Selector<FavoriteProvider, bool>(
        selector: (context, obj) => obj.isLoading,
        builder: (context, isLoading, _) {
          return isLoading
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
              : provider.favoriteList.isNotEmpty
                  ? GridView.builder(
                      itemCount: provider.favoriteList.length,
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
                        final data = provider.favoriteList[index];
                        return GestureDetector(
                          onTap: () {
                            // Routes.push(screen: OverView(data: data));
                          },
                          child: FavoriteItems(data: data),
                        );
                      },
                    )
                  : const Center(
                      child: Text("No Favorite"),
                    );
        },
      ),
    );
  }
}
