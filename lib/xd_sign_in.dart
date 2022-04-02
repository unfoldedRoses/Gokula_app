import 'dart:developer';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gokula/auth/index.dart';

class XDSignIn extends StatelessWidget {
  const XDSignIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
        Navigator.pushNamed(context, 'farmer');
      }
    });

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                Container(
                    // color: const Color(0xffffffff),
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    decoration: const BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(35),
                            topEnd: Radius.circular(35))),
                    child: signInModal(context)),
              ],
            ),
          ),
        ));
  }

  SingleChildScrollView signInModal(BuildContext context) {
    final _signInForm = GlobalKey<FormBuilderState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return SingleChildScrollView(
      child: FormBuilder(
        key: _signInForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'signUp');
                    },
                    child: const Text('Sign up'))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Please sign in to enter in a app',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              validator: ValidationBuilder().required().email().build(),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Email Address'),
                  hintText: 'Enter email address'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              validator: ValidationBuilder().required().build(),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Password'),
                  hintText: 'Enter password'),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      if (_signInForm.currentState!.validate()) {
                        _signInForm.currentState?.save();

                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                        } on FirebaseAuthException catch (e) {
                          debugPrint('firebase error ==> $e');
                          if (e.code == 'user-not-found') {
                            Fluttertoast.showToast(
                                msg: 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            Fluttertoast.showToast(
                                msg: 'Wrong password provided for that user.');
                          }
                        }
                      } else {
                        debugPrint('validation failed...');
                      }
                    },
                    child: const Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ))),
            const SizedBox(
              height: 15,
            ),
            const Text('Login with Social'),
            const SizedBox(
              height: 15,
            ),
            const SocialAuth()
          ],
        ),
      ),
    );
  }
}

class SocialAuth extends StatelessWidget {
  const SocialAuth({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // FacebookAuthButton(
        //   onPressed: () async {
        //     signInWithFacebook()
        //         .then((value) => {debugPrint('Facebook User'), inspect(value)})
        //         .catchError(
        //             // ignore: invalid_return_type_for_catch_error
        //             (error) => debugPrint("Failed to facebook auth: $error"));
        //   },
        //   text: 'Facebook',
        // ),
        GoogleAuthButton(
          onPressed: () async {
            await signInWithGoogle()
                .then((value) => {
                      debugPrint('Google User'),
                      inspect(value),
                      Navigator.pushReplacementNamed(context, 'farmer')
                    })
                .catchError(
                    // ignore: invalid_return_type_for_catch_error
                    (error) => {
                          debugPrint("Failed to google auth: $error"),
                          Future.error(error)
                        });
          },
          text: 'Google',
        ),
      ],
    );
  }
}
