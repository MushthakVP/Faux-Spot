import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/screen/booking/view_model/payment_provider.dart';
import 'package:faux_spot/app/screen/confetti/view_model/confetti_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../core/images.dart';

class ConfettiView extends StatelessWidget {
  const ConfettiView({super.key});

  @override
  Widget build(BuildContext context) {
    ConfettiProvider provider = context.read<ConfettiProvider>();

    return Consumer<PaymentProvider>(
      builder: (context, value, _) {
        value.isLoading ? null : provider.play();
        return value.isLoading
            ? Scaffold(
                backgroundColor: primaryColor,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Payment Processing...',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Lottie.asset(
                        loadingAnimation,
                        height: 130,
                        width: 200,
                      ),
                    ],
                  ),
                ),
              )
            : ColoredBox(
                color: primaryColor,
                child: Stack(
                  children: [
                    ConfettiWidget(
                      shouldLoop: false,
                      confettiController: provider.controller,
                      blastDirection: pi / 3,
                      numberOfParticles: 60,
                      blastDirectionality: BlastDirectionality.explosive,
                      maxBlastForce: 20, // set a lower max blast force
                      minBlastForce: 5, // set a lower min blast force
                      emissionFrequency: 0.02,
                      gravity: 0.02,
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                        Colors.purple,
                        whiteColor,
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Payment Successful".toUpperCase(),
                            style: const TextStyle(
                              color: whiteColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          space10,
                          Lottie.asset(
                            tickAnimation,
                            height: 200,
                            width: 200,
                            repeat: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
