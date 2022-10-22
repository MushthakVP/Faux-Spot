import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/screen/booking/view/widgets/datepicker_widget.dart';
import 'package:faux_spot/app/screen/booking/view_model/booking_provider.dart';
import 'package:faux_spot/app/screen/booking/view_model/payment_provider.dart';
import 'package:faux_spot/app/screen/home/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingView extends StatelessWidget {
  final DataList data;
  const BookingView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    BookingProvider provider = context.read<BookingProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.slotCreate(list: data);
    });

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: uiOverlay(navigate: whiteColor),
        title: Text(data.turfName!),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          space20,
          DatePickerWidget(provider: provider, list: data),
          timeWidget(
              price: data.turfPrice!.morningPrice!.toString(), time: "Morning"),
          Consumer<BookingProvider>(builder: (context, value, _) {
            return Wrap(
              direction: Axis.horizontal,
              children: List.generate(
                provider.morningSlot.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      provider.multiTouch(
                          index: index,
                          time: provider.morningSlot[index].time!,
                          isSelected: provider.morningSlot[index].isSelected!,
                          price: data.turfPrice!.morningPrice!.toDouble());
                    },
                    child: TimeWidget(
                      time: provider.morningSlot[index].time!,
                      provider: provider,
                      book: provider.morningSlot[index].isSelected,
                    ),
                  );
                },
              ),
            );
          }),
          Consumer<BookingProvider>(
            builder: (context, value, _) {
              return Visibility(
                visible: value.afternoonSlot.isNotEmpty,
                child: timeWidget(
                    price: data.turfPrice!.afternoonPrice!.toString(),
                    time: "Afternoon"),
              );
            },
          ),
          Consumer<BookingProvider>(
            builder: (context, value, _) {
              return Wrap(
                direction: Axis.horizontal,
                children: List.generate(
                  provider.afternoonSlot.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        provider.multiTouch(
                            index: index,
                            time: provider.afternoonSlot[index].time!,
                            isSelected:
                                provider.afternoonSlot[index].isSelected!,
                            price: data.turfPrice!.afternoonPrice!.toDouble());
                      },
                      child: TimeWidget(
                        time: provider.afternoonSlot[index].time!,
                        provider: provider,
                        book: provider.afternoonSlot[index].isSelected,
                      ),
                    );
                  },
                ),
              );
            },
          ),
          timeWidget(
              price: data.turfPrice!.eveningPrice!.toString(), time: "Evening"),
          Consumer<BookingProvider>(
            builder: (context, value, _) {
              return Wrap(
                direction: Axis.horizontal,
                children: List.generate(
                  provider.eveningSlot.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        provider.multiTouch(
                          index: index,
                          time: provider.eveningSlot[index].time!,
                          isSelected: provider.eveningSlot[index].isSelected!,
                          price: data.turfPrice!.eveningPrice!.toDouble(),
                        );
                      },
                      child: TimeWidget(
                        time: provider.eveningSlot[index].time!,
                        provider: provider,
                        book: provider.eveningSlot[index].isSelected,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          context.read<PaymentProvider>().bookSlot(list: data);
        },
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: primaryColor,
          ),
          child: Consumer<BookingProvider>(
            builder: (context , value , _) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "₹ ${value.totalAmount}",
                    style: const TextStyle(
                      color: whiteColor,
                      fontSize: 16,
                    ),
                  ),
                  space30,
                  const Text(
                    "BOOK NOW",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 18,
                    ),
                  ),
                  space30,
                  space5,
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  Column timeWidget({required String time, required String price}) {
    return Column(
      children: [
        space20,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            Text(
              "₹ $price",
              style: const TextStyle(
                color: greenColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        space10,
      ],
    );
  }
}

class TimeWidget extends StatelessWidget {
  final BookingProvider provider;
  final String time;
  final bool? book;
  const TimeWidget({
    Key? key,
    required this.time,
    required this.provider,
    this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(5),
      height: 50,
      width: size.width * .279,
      decoration: BoxDecoration(
        color: provider.dataList.contains(time)
            ? lightGreyColor
            : book!
                ? primaryColor
                : whiteColor,
        border: Border.all(
            color: provider.dataList.contains(time)
                ? lightGreyColor
                : primaryColor),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          time,
          style: TextStyle(
            fontSize: 15,
            color: provider.dataList.contains(time)
                ? primaryColor
                : book!
                    ? whiteColor
                    : primaryColor,
          ),
        ),
      ),
    );
  }
}
