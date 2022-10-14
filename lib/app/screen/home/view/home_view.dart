import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/core/images.dart';
import 'package:faux_spot/app/screen/home/view/widget/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
   // HomeProvider provider = context.read<HomeProvider>();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(105),
        child: CustomAppBAr(),
      ),
      body: Column(
        children: [
          const CategoryWidget(),
          Expanded(
            child: Selector<GetUserLoction , bool>(
              selector: (context, obj) => obj.turfListLoading,
              builder: (context , turfListLoading , _) {
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .9,
                  ),
                  itemBuilder: (context, index) {
                    return const HomeScreenItems();
                  },
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreenItems extends StatelessWidget {
  const HomeScreenItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: whiteColour,
        boxShadow: const [
          BoxShadow(
            color: lightGreyColour,
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
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                image: AssetImage(turfImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
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
                          borderRadius:
                              BorderRadius.circular(6),
                          color: primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(
                              Icons.star,
                              color: yellowColor,
                              size: 18,
                            ),
                            Text(
                              "4.3",
                              style: TextStyle(
                                color: whiteColour,
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
          const Expanded(
            child: Text(
              "Faux Turf",
              maxLines: 1,
              style: TextStyle(
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
