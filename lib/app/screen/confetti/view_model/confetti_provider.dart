import 'package:confetti/confetti.dart';
import 'package:faux_spot/app/routes/routes.dart';
import 'package:faux_spot/app/screen/booking/view_model/payment_provider.dart';
import 'package:faux_spot/app/screen/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../routes/messenger.dart';

class ConfettiProvider extends ChangeNotifier {
  PaymentProvider paymentProvider = Messenger
      .rootScaffoldMessengerKey.currentContext!
      .read<PaymentProvider>();

  ConfettiController controller = ConfettiController();
  bool isPlaying = false;

  void play() async {
    controller.play();
    notifyListeners();
    await Future.delayed(const Duration(seconds: 5));
    Routes.pushRemoveUntil(screen: const HomeView());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
