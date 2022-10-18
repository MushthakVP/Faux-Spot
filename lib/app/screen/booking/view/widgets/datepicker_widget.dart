import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fontisto.dart';
import 'package:provider/provider.dart';
import '../../../../core/colors.dart';
import '../../view_model/booking_provider.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final BookingProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<BookingProvider>(builder: (context, obj, _) {
          return Expanded(
            child: SizedBox(
              height: 100,
              child: DatePicker(
                provider.date,
                initialSelectedDate: DateTime.now(),
                selectionColor: primaryColor,
                selectedTextColor: Colors.white,
                daysCount: 4,
                onDateChange: (date) {},
              ),
            ),
          );
        }),
        GestureDetector(
          onTap: () async {
            provider.changeDAte(context);
          },
          child: Container(
            height: 95,
            width: 70,
            decoration: BoxDecoration(
              color: primaryColor,
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
    );
  }
}
