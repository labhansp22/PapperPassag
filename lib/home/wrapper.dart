import 'package:flutter/material.dart';
import 'package:gateprep/views/App%20view/home.dart';
import 'package:gateprep/views/authentication/signin.dart';
import 'package:gateprep/views/authentication/signup.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../views/authentication/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User_?>(context);

    if (user == null) {
      return Authentication();
    } else {
      return Home();
    }
  }
}
// title: 'Flutter Demo',

//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home:SignIn(),
