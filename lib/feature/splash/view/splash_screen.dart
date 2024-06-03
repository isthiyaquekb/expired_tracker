import 'dart:async';

import 'package:expiry_track/core/constant/app_routes.dart';
import 'package:expiry_track/utils/custom_paint/logo_maker.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacementNamed(AppRoutes.onBoard));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomPaint(
              painter: LogoPainter(),
              child: const SizedBox(
                width: 400, // Adjust width and height as needed.
                height: 120,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
