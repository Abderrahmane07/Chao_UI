import 'package:flutter/material.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/LogoBig.png'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/register/',
              );
            },
            child: const Text(
              'Chao',
              style: TextStyle(fontSize: 64),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Make use of your unused time',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
