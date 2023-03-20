import 'package:flutter/material.dart';
import 'package:gateprep/views/authentication/signin.dart';
import 'package:gateprep/views/authentication/signup.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(
        toggleView: toggleView,
      );
    } else {
      return SignUp(toggleView: toggleView);
    }
  }
}
