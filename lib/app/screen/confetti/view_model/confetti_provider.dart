import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiProvider extends ChangeNotifier {

  ConfettiController controller = ConfettiController();
  bool isPlaying = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
