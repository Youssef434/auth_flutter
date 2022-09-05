import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/auth.dart';
import 'package:flutter_base/authenticate.dart';

class Register extends StatefulWidget {

  late final Function toggleView;

  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sign Up'),
        elevation: 5,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.login_sharp, color: Colors.white,),
            onPressed: () {
              widget.toggleView();
            },
            label: const Text('login', style: TextStyle(color: Colors.white,),),
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
                height: 40,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'password',
                ),
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

                  if (value != confirmPassword) {
                    return 'The passwords does not match';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'confirm password',
                ),
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    confirmPassword = val;
                  });
                },
                validator: (value) {
                  if (value != password) {
                    return 'The passwords does not match';
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
                  if(!_formKey.currentState!.validate()) {
                    return;
                  }

                  if (await _authService.registerWithEmailAndPassword(email, password) != null) {
                    return;
                  }

                  setState(() {
                    error = "The email address is already in use by another account.";
                  });
                },
                child: const Text(
                  'Register',
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
