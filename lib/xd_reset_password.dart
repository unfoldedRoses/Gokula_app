import 'package:flutter/material.dart';

class XDResetPassword extends StatefulWidget {
  const XDResetPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<XDResetPassword> createState() => _XDResetPasswordState();
}

class _XDResetPasswordState extends State<XDResetPassword> {
  bool _isObscure = true;

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
                child: resetPasswordWidget()),
          ],
        ));
  }

  Column resetPasswordWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Reset Password',
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
            'Please sign up to enter in a app.',
            style: TextStyle(color: Color(0xFF888888), fontSize: 16),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          obscureText: _isObscure,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: const Text('Old password'),
              hintText: 'Enter email address',
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off))),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('New password'),
              hintText: 'Enter OTP'),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Confirm password'),
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
                  'Update Password',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ))),
      ],
    );
  }
}
