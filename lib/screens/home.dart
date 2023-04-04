import 'package:flutter/material.dart';
import 'package:kharcharecord/controllers/auth_controllers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              onPressed: () => AuthController.instance.signingOut(),
              child: const Text("Logout"))
        ],
      ),
      body: const Center(
        child: Text("Welcome Home"),
      ),
    );
  }
}
