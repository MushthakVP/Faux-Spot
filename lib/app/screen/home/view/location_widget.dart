import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/core/images.dart';
import 'package:faux_spot/app/screen/home/service/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:provider/provider.dart';

class LocationPick extends StatelessWidget {
  const LocationPick({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: locationBackground,
      appBar: AppBar(
        backgroundColor: transparentColor,
        systemOverlayStyle: uiOverlay(
          status: locationBackground,
          navigate: locationBackground,
          brightness: Brightness.dark,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.asset(locationImage),
            ),
            space30,
            const Text(
              "Where do you want to play?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 27,
                color: primaryColor,
              ),
            ),
            space10,
            const Text(
              "To enjoy all that FauxSpot has offer you  we need to know where to look for them",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                GetUserLocation().getUserLocation(checkScreen: true);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Selector<GetUserLocation, bool>(
                  selector: (context, obj) => obj.isLoading,
                  builder: (context, loading, _) {
                    return loading
                        ? const Center(
                            child: CupertinoActivityIndicator(
                              color: whiteColor,
                            ),
                          )
                        : Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Iconify(
                                  Fa6Solid.location_arrow,
                                  color: whiteColor,
                                  size: 25,
                                ),
                                space30,
                                Text(
                                  "Around me",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 18,
                                  ),
                                ),
                                space30,
                              ],
                            ),
                          );
                  },
                ),
              ),
            ),
            space30,
            const Text(
              "Set location manually",
              style: TextStyle(
                color: primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
