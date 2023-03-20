import 'package:flutter/material.dart';

import 'package:gateprep/models/user.dart';
import 'package:gateprep/services/auth.dart';
import 'package:gateprep/views/App%20view/home.dart';
import 'package:gateprep/views/authentication/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'home/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User_?>.value(
      initialData: null,
      value: AuthService().user,
      catchError: (_, err) => null,
      // ignore: prefer_const_constructors
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
