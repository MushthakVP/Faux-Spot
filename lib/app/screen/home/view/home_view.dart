import 'dart:developer';
import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/screen/home/view_model/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/eva.dart';
import 'package:provider/provider.dart';
import '../service/location.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    GetUserLoction location = context.read<GetUserLoction>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      location.getUserLocation();
    });
    HomeProvider provider = context.read<HomeProvider>();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(105),
        child: CustomAppBAr(),
      ),
      body: Column(
        children: [
          LimitedBox(
            maxHeight: 60,
            child: ListView.builder(
              itemCount: provider.categoryList.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final listData = provider.categoryList[index];
                log(listData.image.toString());
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  color: primaryColor,
                  height: 200,
                  width: 200,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBAr extends StatelessWidget {
  const CustomAppBAr({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GetUserLoction>(builder: (context, value, _) {
      return Container(
        color: primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                space20,
                const Iconify(
                  Carbon.location,
                  color: whiteColour,
                  size: 16,
                ),
                space10,
                value.userLocation == null
                    ? const Text("")
                    : Text(
                        value.userLocation.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: whiteColour,
                        ),
                      ),
                const Iconify(
                  Eva.arrow_down_outline,
                  color: lightGreyColour,
                  size: 20,
                ),
                const Spacer(),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: lightGreyColour,
                ),
              ),
              child: const Center(
                child: TextField(
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.1,
                    color: Colors.white,
                    letterSpacing: .8,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      height: .9,
                      color: lightGreyColour,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
