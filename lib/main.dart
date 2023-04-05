import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kharcharecord/controllers/auth_controllers.dart';
import 'package:kharcharecord/firebase_options.dart';
import 'package:kharcharecord/screens/home.dart';
import 'package:kharcharecord/screens/login_otp.dart';
import 'package:kharcharecord/screens/welcome.dart';

import 'screens/login_mobile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (value) => Get.put(AuthController()),
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
    return GetMaterialApp(
      title: "Kharcha Record",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        useMaterial3: true,
      ),
      getPages: [
        GetPage(name: "/welcome", page: () => const WelcomeScreen()),
        GetPage(name: "/phone", page: () => const LoginMobile()),
        GetPage(name: "/otp", page: () => const LoginOTP()),
        GetPage(name: "/home", page: () => const HomeScreen()),
        GetPage(name: "/loading", page: () => const LoadingScreen()),
      ],
      initialRoute: "/loading",
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          "Loading ...",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
