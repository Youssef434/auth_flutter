import 'package:flutter/material.dart';
import 'package:flutter_base/app_user.dart';
import 'package:flutter_base/authenticate.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Wrapper extends StatelessWidget {
  final state = const Authenticate().createState();

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser?>(context);
    if (appUser == null)
      return Authenticate();

    return HomePage();
  }
}
