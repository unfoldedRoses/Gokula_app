import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:form_validator/form_validator.dart';
import 'package:gokula/xd_sign_in.dart';

class XDSignUp extends StatefulWidget {
  const XDSignUp({
    Key? key,
  }) : super(key: key);

  @override
  State<XDSignUp> createState() => _XDSignUpState();
}

class _XDSignUpState extends State<XDSignUp> {
  bool _isObscure = true;
  bool _isConfirmObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                height: 5,
              ),
              Container(
                  // color: const Color(0xffffffff),
                  padding: const EdgeInsets.all(30.0),
                  decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(35),
                          topEnd: Radius.circular(35))),
                  child: signInModal(context)),
            ],
          ),
        ));
  }

  SingleChildScrollView signInModal(BuildContext context) {
    final _signUpForm = GlobalKey<FormBuilderState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return SingleChildScrollView(
      child: FormBuilder(
        key: _signUpForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sign up',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF36596A)),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: Color(0xFFCCCCCC), fontSize: 15),
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Please sign in to enter in a app',
                style: TextStyle(color: Color(0xFF888888)),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            FormBuilderTextField(
              name: 'email',
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
            FormBuilderTextField(
              name: 'password',
              controller: _passwordController,
              validator: ValidationBuilder().required().minLength(6).build(),
              obscureText: _isObscure,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text('Password'),
                  hintText: 'Enter password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(_isObscure
                          ? Icons.visibility
                          : Icons.visibility_off))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: ValidationBuilder().required().minLength(6).build(),
              obscureText: _isConfirmObscure,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text('Confirm Password'),
                  hintText: 'Enter confirm password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isConfirmObscure = !_isConfirmObscure;
                        });
                      },
                      icon: Icon(_isConfirmObscure
                          ? Icons.visibility
                          : Icons.visibility_off))),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      _signUpForm.currentState?.save();
                      if (_signUpForm.currentState!.validate()) {
                        inspect(_signUpForm.currentState?.value);

                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            debugPrint('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            debugPrint(
                                'The account already exists for that email.');
                          }
                        } catch (e) {
                          inspect(e);
                        }
                      } else {
                        debugPrint('failed');
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
            const SocialAuth(),
          ],
        ),
      ),
    );
  }
}
