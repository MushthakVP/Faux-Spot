import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/screen/booking/view_model/booking_provider.dart';
import 'package:faux_spot/app/screen/home/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fontisto.dart';
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
        title: const Text('BookingView'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          space20,
          Row(
            children: [
              Expanded(
                child: Consumer<BookingProvider>(
                  builder: (context , obj , _ ) {
                    return SizedBox(
                      height: 100,
                      child: DatePicker(
                        provider.date,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Colors.black,
                        selectedTextColor: Colors.white,
                        daysCount: 4,
                        onDateChange: (date) {},
                      ),
                    );
                  }
                ),
              ),
              GestureDetector(
                onTap: () async {
                  provider.changeDAte(context);
                  
                },
                child: Container(
                  height: 95,
                  width: 70,
                  decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Iconify(
                      Fontisto.date,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Morning ",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(
                "₹ ${data.turfTime!.timeMorning.toString()}",
                style: const TextStyle(
                  color: greenColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
