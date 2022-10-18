import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/screen/booking/view/widgets/datepicker_widget.dart';
import 'package:faux_spot/app/screen/booking/view_model/booking_provider.dart';
import 'package:faux_spot/app/screen/home/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingView extends StatelessWidget {
  final DataList data;
  const BookingView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    BookingProvider provider = context.read<BookingProvider>();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: uiOverlay(navigate: whiteColor),
        title:  Text(data.turfName!),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          space20,
          DatePickerWidget(provider: provider),
          space20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Morning ",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(
                "₹ ${data.turfTime!.timeMorning!}",
                style: const TextStyle(
                  color: greenColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Wrap(children: [
            Container(
              
            ),
          ],),
        ],
      ),
    );
  }
}
