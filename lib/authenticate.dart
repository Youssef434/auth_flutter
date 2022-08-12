import 'package:flutter/material.dart';
import 'package:flutter_base/register.dart';
import 'package:flutter_base/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void _toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ? SignInPage(toggleView: _toggleView) : Register(toggleView: _toggleView);
  }
}
