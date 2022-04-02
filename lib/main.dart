import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gokula/Forms/farmer_dairy_form.dart';
import 'package:gokula/about_us.dart';
import 'package:gokula/xd_forgot_password.dart';
import 'package:gokula/xd_reset_password.dart';
import 'package:gokula/xd_sign_in.dart';
import 'package:gokula/xd_sign_up.dart';
import 'package:gokula/xd_walkthrough01.dart';

// Import the generated file
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      return MaterialApp(
        title: 'Gokula',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const XDSignIn(),
          'aboutUs': (context) => const AboutUs(),
          'welcome': (context) => const XDWalkthrough01(),
          'signUp': (context) => const XDSignUp(),
          'forgotPassword': (context) => const XDForgotPassword(),
          'resetPassword': (context) => const XDResetPassword(),
          'farmer': (context) => const DairyFarmer(),
        },
      );
    });
  }
}
