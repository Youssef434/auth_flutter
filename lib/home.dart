import 'package:flutter/material.dart';

import 'auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await AuthService().signOut();
            },
            label: const Text(
              'Log out',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
