import 'dart:developer';

import 'package:faux_spot/app/screen/booking/service/booking_service.dart';
import 'package:faux_spot/app/screen/booking/view_model/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../core/colors.dart';
import '../../../routes/messenger.dart';
import '../../home/model/home_model.dart';

class PaymentProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  BookingProvider bookingProvider = Messenger
      .rootScaffoldMessengerKey.currentContext!
      .read<BookingProvider>();

  Razorpay _razorpay = Razorpay();

  DataList? list;

  PaymentProvider() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Map<String, dynamic> data = {
      "booking_date": DateFormat.yMd().format(bookingProvider.bookingDAte),
      "turf_id": list!.id,
      "time_slot": bookingProvider.selectedAddList,
    };

    BookingService().bookingMethod(data: data);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log('Payment error');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log('External Wallet');
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void bookSlot({required DataList list}) async {
    this.list = list;
    if (bookingProvider.totalAmount >= 1) {
      var options = {
        'key': "rzp_test_GTHJIvzIb2IAo4",
        'amount': bookingProvider.totalAmount * 100,
        'name': 'FauxSpot',
        'description': list.turfName,
        'prefill': {
          'contact': 9061213930,
        },
        'timeout': 300,
        'modal': {
          'confirm_close': true,
          'external': {
            'wallets': ['paytm']
          }
        }
      };
      try {
        _razorpay.open(options);
        notifyListeners();
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      Messenger.pop(msg: "Please Select Slot", color: redColor);
    }
  }
}
