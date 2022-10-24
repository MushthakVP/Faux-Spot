import 'package:confetti/confetti.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/screen/confetti/view_model/confetti_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfettiView extends StatelessWidget {
  const ConfettiView({super.key});

  @override
  Widget build(BuildContext context) {
    ConfettiProvider provider = context.read<ConfettiProvider>();
    provider.controller.play();
    return ColoredBox(
      color: primaryColor,
      child: ConfettiWidget(
        strokeColor: primaryColor,
        blastDirectionality: BlastDirectionality.explosive,
        blastDirection: 5,
        emissionFrequency: 0.05,
        numberOfParticles: 20,
        shouldLoop: true,
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple,
          whiteColor,
        ],
        confettiController: provider.controller,
      ),
    );
  }
}
