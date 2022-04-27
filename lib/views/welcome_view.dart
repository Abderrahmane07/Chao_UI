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
            image: NetworkImage(
                'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZSWUCiXJ4kYigEuAedEKwaoCccFy_C6SyvTy2k4et-jiWynSQgalIUJE5f7iXxu4w5JT0iv3NFFbpyRqbgCBcpDXTBnfNwydKNxKHTdmmpt9e8RRe4TLPa0MSr1x-Tw7rfXSJq7ajeFC8fM7SgL8gRNayl78UBrwNsWdzHLo8Hv3GbYP3yFjbx-17/s16000/LogoBig.png'),
            //image: AssetImage('assets/LogoBig.png'),
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
