import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/screen/home/model/home_model.dart';
import 'package:faux_spot/app/screen/overview/view_model/overview_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'widgets/amenities_widget.dart';
import 'widgets/custom_appbar.dart';

class OverView extends StatelessWidget {
  final DataList data;
  const OverView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    OverViewProvider provider = context.read<OverViewProvider>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        SystemChrome.setSystemUIOverlayStyle(
          uiOverlay(status: transparentColor),
        );
        provider.changeAppbarImage(
          image: data.turfImages!.turfImages1.toString(),
        );
      },
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(270),
        child: CustomAppBar(data: data),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            space5,
            const Text(
              "Amenities",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            space10,
            amenities(provider)
          ],
        ),
      ),
    );
  }

  LimitedBox amenities(OverViewProvider provider) {
    return LimitedBox(
            maxHeight: 200,
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                AmenitiesWidget(
                  icon: provider.amenitiesList[0].icon,
                  name: provider.amenitiesList[0].name,
                  visible: data.turfAmenities!.turfParking!,
                ),
                AmenitiesWidget(
                  icon: provider.amenitiesList[1].icon,
                  name: provider.amenitiesList[1].name,
                   visible: data.turfAmenities!.turfGallery!,
                ),
                AmenitiesWidget(
                  icon: provider.amenitiesList[2].icon,
                  name: provider.amenitiesList[2].name,
                   visible: data.turfAmenities!.turfWater!,
                ),
                AmenitiesWidget(
                  icon: provider.amenitiesList[3].icon,
                  name: provider.amenitiesList[3].name,
                   visible: data.turfAmenities!.turfDressing!,
                ),
                AmenitiesWidget(
                  icon: provider.amenitiesList[4].icon,
                  name: provider.amenitiesList[4].name,
                   visible: data.turfAmenities!.turfWashroom!,
                ),
                AmenitiesWidget(
                  icon: provider.amenitiesList[5].icon,
                  name: provider.amenitiesList[5].name,
                   visible: data.turfAmenities!.turfCafeteria!,
                ),
              ],
            ),
          );
  }
}
