import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to Kharcha Record",
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Get.toNamed("/loginMobile"),
              child: const Text("Login Now"),
            )
          ],
        ),
      ),
    );
  }
}
