import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import '../../services/auth_service.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    if (authService.currentUser != null) {
      return const ProfileScreen();
    } else {
      return const LoginScreen();
    }
  }
}
