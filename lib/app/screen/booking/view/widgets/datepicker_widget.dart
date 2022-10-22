import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fontisto.dart';
import 'package:provider/provider.dart';
import '../../../../core/colors.dart';
import '../../../home/model/home_model.dart';
import '../../view_model/booking_provider.dart';

class DatePickerWidget extends StatelessWidget {
  final DataList list;
  const DatePickerWidget({
    Key? key,
    required this.provider,required this.list,
  }) : super(key: key);

  final BookingProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<BookingProvider>(builder: (context, obj, _) {
          return Expanded(
            child: SizedBox(
              height: 98,
              child: DatePicker(
                provider.date,
                width: 65,
                initialSelectedDate: provider.date,
                selectionColor: primaryColor,
                selectedTextColor: Colors.white,
                daysCount: 4,
                onDateChange: (date) {
                  provider.refreshSelect();
                  provider.slotCreate(list: list , dateOn : date);
                },
              ),
            ),
          );
        }),
        GestureDetector(
          onTap: () async {
            provider.changeDAte(context : context , list: list);
          },
          child: Container(
            height: 95,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Iconify(
                Fontisto.date,
                color: primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
