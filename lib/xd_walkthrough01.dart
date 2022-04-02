import 'package:flutter/material.dart';

class XDWalkthrough01 extends StatelessWidget {
  const XDWalkthrough01({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/topbar_alt.png'),
                  fit: BoxFit.fill)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  // color: const Color(0xffffffff),
                  padding: const EdgeInsets.all(30.0),
                  decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(35),
                          topEnd: Radius.circular(35))),
                  child: walkThrough1(context)),
            ],
          ),
        ));
  }

  Column walkThrough1(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: const DecorationImage(
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'On Demand',
          style: TextStyle(color: Color(0xff36596A), fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Welcome',
          style: TextStyle(color: Color(0xff36596A), fontSize: 32),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Apart from export and import of organic products. Started own organic farming from 1989 in Karnataka.',
          style: TextStyle(color: Color(0xff888888), fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'signIn');
            },
            child: const Text('Get Started'))
      ],
    );
  }
}
