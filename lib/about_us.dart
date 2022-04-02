import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(image: AssetImage('assets/images/aboutus.jpeg')),
              const SizedBox(
                height: 50.0,
              ),
              const Image(image: AssetImage('assets/images/about_gokula.jpg')),
              const SizedBox(
                height: 50.0,
              ),
              const Text(
                'Kindly stay tuned. Product Section is coming soon...',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(
                height: 50.0,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, '/');
                  },
                  child: const Text('Close'))
            ],
          ),
        ),
      ),
    );
  }
}
