import 'dart:developer';

import 'package:faux_spot/app/screen/booking/view_model/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../core/colors.dart';
import '../../../routes/messenger.dart';
import '../../home/model/home_model.dart';

class PaymentProvider extends ChangeNotifier {
  BookingProvider bookingProvider = Messenger
      .rootScaffoldMessengerKey.currentContext!
      .read<BookingProvider>();

   Razorpay _razorpay = Razorpay();

  PaymentProvider() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log('Payment success');
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
    log(" selected list ${bookingProvider.selectedAddList}");
    if (bookingProvider.totalAmount >= 1) {
      var options = {
        'key': "rzp_test_GTHJIvzIb2IAo4",
        'amount': bookingProvider.totalAmount * 100,
        'name': 'FauxSpot',
        'description': list.turfName,
        'prefill': {'contact': 9061213930, },
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
