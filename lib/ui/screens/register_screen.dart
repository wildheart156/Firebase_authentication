import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();

  String errorMessage = '';

  Future<void> register() async {
    try {
      await authService.register(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        errorMessage = "Registration failed.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Register", style: TextStyle(fontSize: 28)),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),

            ElevatedButton(
              onPressed: register,
              child: const Text("Create Account"),
            ),

            Text(errorMessage),
          ],
        ),
      ),
    );
  }
}
