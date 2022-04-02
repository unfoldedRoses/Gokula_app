import 'package:flutter/material.dart';

class XDForgotPassword extends StatelessWidget {
  const XDForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
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
                padding: const EdgeInsets.all(30.0),
                decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(35),
                        topEnd: Radius.circular(35))),
                child: forgotPasswordWidget()),
          ],
        ));
  }

  Column forgotPasswordWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Forgot Password',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF36596A)),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Enter the email address associated with your account.',
            style: TextStyle(color: Color(0xFF888888), fontSize: 16),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            child: const Text(
              'Resend OTP',
              style: TextStyle(color: Color(0xFF36596A)),
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Email Address'),
              hintText: 'Enter email address'),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Enter OTP'),
              hintText: 'Enter OTP'),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Reset Password',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ))),
      ],
    );
  }
}
