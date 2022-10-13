import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
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
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: uiOverlay(
          status: primaryColor,
          brightness: Brightness.light,
        ),
        title: const CustomAppBAr(),
      ),
      body: ElevatedButton(
        onPressed: (() {
          location.getUserLocation();
        }),
        child: const Text("djiuhyguijhjk"),
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
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Iconify(
                Carbon.location,
                color: whiteColour,
                size: 16,
              ),
              space10,
              value.isLoaidng
                  ? const Text("")
                  : Text(
                      value.userLocation.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
              const Iconify(
                Eva.arrow_down_outline,
                color: lightGreyColour,
                size: 20,
              )
            ],
          ),
          Row(
            children:  const [
              SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(),),
            ],
          ),
        ],
      );
    });
  }
}
