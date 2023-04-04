import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kharcharecord/controllers/auth_controllers.dart';
import 'package:kharcharecord/utils/custom_widgets.dart';
import 'package:pinput/pinput.dart';

class LoginOTP extends StatefulWidget {
  const LoginOTP({super.key});

  @override
  State<LoginOTP> createState() => _LoginOTPState();
}

class _LoginOTPState extends State<LoginOTP> {
  String verificationId = Get.parameters["verificationId"]!;
  String otp = "";
  String phoneNumber = Get.parameters["phoneNumber"]!;
  late Timer _timer;
  int _start = 60;
  bool isLoading = false;
  bool isResendLoading = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "OTP Verification",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter recieved otp at your mobile",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 70,
                  padding: const EdgeInsets.all(10),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onCompleted: (value) {
                  setState(() {
                    otp = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? const CircularProgressIndicator(color: Colors.black)
                  : TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (otp.length < 6) {
                          showSnackBar(
                            title: "Warning...",
                            message: "Enter Valid OTP.",
                          );
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          AuthController.instance
                              .verifyOTP(verificationId, otp);
                        }
                      },
                      child: const Text("Verify"),
                    ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _start == 0
                    ? [
                        const Text("Don't recieved OTP? "),
                        TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          onPressed: () async {
                            startTimer();
                            await AuthController.instance
                                .signInWithPhone(phoneNumber);
                          },
                          child: const Text("Resend"),
                        ),
                      ]
                    : [
                        const Text("You can resend otp after "),
                        Text(
                          "$_start",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
