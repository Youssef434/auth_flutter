import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/authenticate.dart';
import 'package:provider/provider.dart';

import 'app_user.dart';
import 'auth.dart';

class SignInPage extends StatefulWidget {
  late final Function toggleView;

  SignInPage({required this.toggleView});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sign In'),
        elevation: 5,
        actions: [
          TextButton.icon(
            icon: const Icon(
              Icons.login_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              widget.toggleView();
            },
            label: const Text(
              'register',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'email',
                ),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  if (!EmailValidator.validate(email)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'password',
                ),
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  if (value.length < 6) {
                    return 'The password must have at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith(
                    (states) => const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  textStyle: MaterialStateProperty.resolveWith(
                      (states) => const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                ),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  if (await _authService.signIn(email, password) != null) {
                    return;
                  }

                  setState(() {
                    error = 'Something went wrong. Please try again !';
                  });
                },
                child: const Text(
                  'Log In',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                error,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
