import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  TextEditingController phoneController = TextEditingController();
  String phone = "";
  Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: '');
  Color counterColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    if (phoneController.text.length < 6) {
      setState(() {
        counterColor = Colors.red;
      });
    } else if (phoneController.text.length < 10) {
      setState(() {
        counterColor = Colors.orange;
      });
    } else {
      setState(() {
        counterColor = Colors.green.shade700;
      });
    }
    return Scaffold(
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
                "Phone Authentication",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "You need to login to start app.",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: phoneController,
                onChanged: (value) {
                  setState(() {});
                },
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLength: 10,
                decoration: InputDecoration(
                  counter: Text(
                    "${phoneController.text.length}",
                    style: TextStyle(
                      color: counterColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Enter Mobile Number",
                  prefixIcon: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      showCountryPicker(
                        context: context,
                        countryListTheme: const CountryListThemeData(
                          bottomSheetHeight: 550,
                        ),
                        onSelect: (value) {
                          setState(() {
                            selectedCountry = value;
                          });
                        },
                      );
                    },
                    child: Text(
                      "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  suffixIcon: phoneController.text.length < 10
                      ? null
                      : IconButton(
                          onPressed: () => Get.toNamed("/loginOTP"),
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.green,
                          )),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
