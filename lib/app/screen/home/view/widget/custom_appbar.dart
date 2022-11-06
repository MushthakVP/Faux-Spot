import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/screen/home/view_model/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pov = context.read<HomeProvider>();
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: primaryColor,
      title: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: greyColor.withOpacity(.3),
        ),
        width: double.infinity,
        child: TextField(
          focusNode: pov.focus,
          controller: pov.searchController,
          style: const TextStyle(
            height: 1.6,
            color: Colors.white,
            letterSpacing: .8,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: Consumer<HomeProvider>(
              builder: (context, value, _) {
                return Visibility(
                  // visible: value.searchValueChecking,
                  child: IconButton(
                    onPressed: () {
                      pov.searchValueChange(false);
                    },
                    icon: const Icon(
                      Icons.close_sharp,
                      color: whiteColor,
                    ),
                  ),
                );
              },
            ),
            hintText: 'Search',
            hintStyle: const TextStyle(
              color: greyColor,
              fontSize: 16,
            ),
          ),
          onChanged: (String data) {
            pov.getSearchKeyword(value: data);
          },
        ),
      ),
    );
  }
}
