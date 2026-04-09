import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream of auth state changes
  Stream<User?> authState() => _auth.authStateChanges();

  // Register user
  Future<UserCredential> register(String email, String pass) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleError(e);
    }
  }
  // Sign in user
  Future<UserCredential> signIn(String email, String pass) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleError(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Change password
  Future<void> changePassword(String newPassword) async {
    final user = _auth.currentUser;

    if (user != null) {
      await user.updatePassword(newPassword);
    }
  }

  // Get current user
  User? getCurrentUser() => _auth.currentUser;

  // Friendly Firebase error messages
  String _handleError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Use at least 6 characters with a number.';
      case 'email-already-in-use':
        return 'That email is already in use.';
      case 'user-not-found':
        return 'No account found for that email.';
      case 'wrong-password':
        return 'Incorrect password entered.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'invalid-credential':
        return 'Login credentials are invalid or expired.';
      default:
        return e.message ?? 'Authentication failed.';
    }
  }
}