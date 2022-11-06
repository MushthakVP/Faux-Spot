import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/core/images.dart';
import 'package:faux_spot/app/routes/routes.dart';
import 'package:faux_spot/app/screen/booking/view/booking_view.dart';
import 'package:faux_spot/app/screen/booking/view_model/booking_provider.dart';
import 'package:faux_spot/app/screen/home/model/home_model.dart';
import 'package:faux_spot/app/screen/overview/view/widgets/custom_appbar.dart';
import 'package:faux_spot/app/screen/overview/view_model/overview_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'widgets/amenities_widget.dart';

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
      body: Column(
        children: [
          CustomAppBar(data: data),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                space10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data.turfName.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      data.turfInfo!.turfRating.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: yellowColor,
                    ),
                  ],
                ),
                Selector<OverViewProvider, bool>(
                  selector: (context, obj) => obj.isLoading,
                  builder: (context, loading, _) {
                    return loading
                        ? Shimmer.fromColors(
                            baseColor: whiteColor,
                            highlightColor: lightGreyColor,
                            child: SizedBox(
                              height: 25,
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: lightGreyColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          )
                        : Text(
                            "${provider.getRecentBooking()} Recent Bookings",
                            style: const TextStyle(
                              color: redColor,
                            ),
                          );
                  },
                ),
                space10,
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          provider.changePriceOnTap();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 6),
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Center(
                            child: Text("PRICING"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                space10,
                Consumer<OverViewProvider>(
                  builder: (context, value, _) {
                    return Visibility(
                      visible: value.priceOnTap,
                      child: AnimatedContainer(
                        width: provider.priceOnTap ? 500 : 0,
                        height: provider.priceOnTap ? 200 : 0,
                        color:
                            provider.priceOnTap ? Colors.white : Colors.white12,
                        alignment: provider.priceOnTap
                            ? Alignment.center
                            : AlignmentDirectional.centerStart,
                        duration: const Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn,
                        child: Container(
                          color: greenColor,
                          height: 60,
                          width: 90,
                        ),
                      ),
                    );
                  },
                ),
                space10,
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
                amenities(provider),
                space10,
                InkWell(
                  onTap: () {
                    provider.openMap(data.turfInfo!.turfMap!);
                  },
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                        image: AssetImage(mapImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
        ],
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
