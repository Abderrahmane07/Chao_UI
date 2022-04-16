import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tentative_chao_1/services/auth/auth_exceptions.dart';

import '../functions/error_dialog.dart';
import '../services/auth/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const Image(
          //   image: AssetImage('assets/Homme_1.png'),
          // ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: _email,
              //enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          OutlinedButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                // final userCredential = await FirebaseAuth.instance
                //     .createUserWithEmailAndPassword(
                //         email: email, password: password);
                // print('Voila: ${userCredential.credential} jusque la');

                await AuthService.firebase()
                    .logIn(email: email, password: password);
                final user = AuthService.firebase().currentUser;
                // TO ADD here if the user is new or not
                if (user?.isEmailVerified ?? false) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/choice/', (route) => false);
                } else {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/verify/', (route) => false);
                }

                // devtools.log(userCredential.toString());
              } on UserNotFoundAuthException {
                await showErrorDialog(context, "User not found");
              } on WrongPasswordAuthException {
                await showErrorDialog(context, "Wrong credentials");
              } on NetworkRequestFailedAuthException {
                await showErrorDialog(
                    context, "Check your internet connection please");
              } on GenericAuthException {
                await showErrorDialog(context, "Authentication error");
              }
            },
            child: const Text('Connecter'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/register/', (route) => false);
            },
            child: const Text("Don't have an account yet? Create one here"),
          ),
        ],
      ),
    );
  }
}
