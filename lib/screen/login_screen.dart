import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_app/main.dart';
import '../controller/google_auth_controller.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          const Text(
            "Welcome,",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _onGoogleSignIn,
              icon: Image.asset(
                'assets/google_icon.png',
                scale: 15,
              ),
              label: _isLoading
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
                  : const Text(
                "Sign-In with Google",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "By sign in your account",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    User? user = await _authController.signInWithGoogle();

    if (user != null) {
      Future.microtask(() {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const UserDeciderScreen(),
          ),
              (route) => false,
        );
      });

      showToast("Login Successfully", false);

      // ignore: avoid_print
      print("Google Sign-In Successful: ${user.displayName}");
    } else {
      showToast("Login Failed", true);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void showToast(String message, bool isFailure) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: isFailure ? Colors.red : Colors.green,
      //
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
