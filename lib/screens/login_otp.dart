import 'package:flutter/material.dart';

class LoginOTP extends StatefulWidget {
  const LoginOTP({super.key});

  @override
  State<LoginOTP> createState() => _LoginOTPState();
}

class _LoginOTPState extends State<LoginOTP> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Login OTP"),
      ),
    );
  }
}
