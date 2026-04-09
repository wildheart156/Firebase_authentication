import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();

  String errorMessage = '';

  Future<void> signIn() async {
    try {
      await authService.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    } catch (e) {
      setState(() {
        errorMessage = "Login failed. Check credentials.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sign In", style: TextStyle(fontSize: 28)),

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(onPressed: signIn, child: const Text("Sign In")),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                child: const Text("Register"),
              ),

              Text(errorMessage),
            ],
          ),
        ),
      ),
    );
  }
}
