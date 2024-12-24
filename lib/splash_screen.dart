import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var opacity = 0.0;
  var width = Get.width;

  @override
  void initState() {
    super.initState();

    // Trigger the opacity change after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0;
      });
    });

    // Navigate to the HomePage after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Get.off(() => const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 2),
            curve: Curves.easeIn,
            opacity: opacity,
            child: Text(
              "Grocify",
              style: TextStyle(
                fontSize: width * 0.1,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
