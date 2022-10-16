import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:flutter/material.dart';
import '../../widgets/shimmer.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: uiOverlay(
          status: primaryColor,
          navigate: whiteColor,
          brightness: Brightness.light,
        ),
        title: const Text("Favorite"),
      ),
      body: GridView.builder(
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
      ),
    );
  }
}
