import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService authService = AuthService();
  final passwordController = TextEditingController();

  String message = '';

  Future<void> updatePassword() async {
    try {
      await authService.changePassword(
        passwordController.text.trim(),
      );

      setState(() {
        message = "Password updated successfully.";
      });
    } catch (e) {
      setState(() {
        message = "Password update failed.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = authService.getCurrentUser();

    return Scaffold(
      backgroundColor: Colors.blueGrey[950],
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.account_circle, size: 80),

                  const SizedBox(height: 20),

                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    user?.email ?? "No Email Found",
                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 30),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "New Password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  if (message.isNotEmpty)
                    Text(
                      message,
                      style: const TextStyle(color: Colors.green),
                    ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: updatePassword,
                      child: const Text("Change Password"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {
                        await authService.signOut();
                      },
                      child: const Text("Logout"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}