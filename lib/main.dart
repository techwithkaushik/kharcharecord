import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kharcharecord/screens/login_otp.dart';
import 'package:kharcharecord/screens/welcome.dart';

import 'screens/login_mobile.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Kharcha Record",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
        ),
        primarySwatch: Colors.cyan,
        useMaterial3: true,
      ),
      getPages: [
        GetPage(name: "/welcome", page: () => const WelcomeScreen()),
        GetPage(name: "/loginMobile", page: () => const LoginMobile()),
        GetPage(name: "/loginOTP", page: () => const LoginOTP()),
      ],
      initialRoute: "/welcome",
    );
  }
}
