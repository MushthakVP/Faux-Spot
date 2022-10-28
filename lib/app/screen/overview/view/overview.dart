import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/routes/routes.dart';
import 'package:faux_spot/app/screen/booking/view/booking_view.dart';
import 'package:faux_spot/app/screen/booking/view_model/booking_provider.dart';
import 'package:faux_spot/app/screen/home/model/home_model.dart';
import 'package:faux_spot/app/screen/overview/view_model/overview_provider.dart';
import 'package:flutter/cupertino.dart';
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
          uiOverlay(
            status: transparentColor,
            navigate: primaryColor,
          ),
        );
        provider.getBookingData(list: data);
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
            space10,
            Text(
              data.turfName.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            space5,
            Row(
              children: const [
                Text(
                  "Amenities",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            space5,
            amenities(provider)
          ],
        ),
      ),
      bottomSheet: bottomSheet(context),
    );
  }

  Selector bottomSheet(BuildContext context) {
    return Selector<OverViewProvider, bool>(
        selector: (context, obj) => obj.isLoading,
        builder: (context, loading, _) {
          return GestureDetector(
            onTap: () {
              context.read<BookingProvider>().date = DateTime.now();
              loading ? null : Routes.push(screen: BookingView(data: data));
            },
            child: SizedBox(
              height: 60,
              child: ColoredBox(
                color: primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading
                        ? const Center(
                            child:
                                CupertinoActivityIndicator(color: whiteColor),
                          )
                        : const Text(
                            "Pick your time slot",
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 18,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        });
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
