import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kharcharecord/controllers/auth_controllers.dart';

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
  bool isLoading = false;
  Widget? showArrow;

  @override
  Widget build(BuildContext context) {
    if (phoneController.text.length == 10) {
      setState(() {
        counterColor = Colors.green.shade700;
        if (isLoading) {
          showArrow = Container(
            padding: const EdgeInsets.all(10),
            height: 20,
            width: 20,
            child: const CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        } else {
          showArrow = IconButton(
            onPressed: () async {
              if (!isLoading) {
                setState(() {
                  isLoading = true;
                });
              }
              await AuthController.instance.signInWithPhone(
                "+${selectedCountry.phoneCode}${phoneController.text}",
              );
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.green,
            ),
          );
        }
      });
    } else {
      setState(() {
        counterColor = Colors.red;
        showArrow = null;
      });
    }
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
                "Phone Authentication",
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
                  setState(() {
                    if (value.length < 10) {
                      isLoading = false;
                    }
                  });
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
                  suffixIcon: showArrow,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
