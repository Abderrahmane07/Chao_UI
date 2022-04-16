import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:tentative_chao_1/services/auth/auth_exceptions.dart';
import 'package:tentative_chao_1/services/auth/auth_service.dart';

import '../functions/error_dialog.dart';
import '../services/auth/auth_service.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
            height: 50,
          ),
          OutlinedButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                // final userCredential = await FirebaseAuth.instance
                //     .createUserWithEmailAndPassword(
                //         email: email, password: password);
                // userCredential.additionalUserInfo?.isNewUser;
                // userCredential.additionalUserInfo?.providerId;

                // print('Voila: ${userCredential.user?.uid} jusque la');
                await AuthService.firebase()
                    .createUser(email: email, password: password);
                final user = FirebaseAuth.instance.currentUser;
                FirebaseFirestore.instance
                    .collection('Users')
                    .doc(user?.uid)
                    .set({
                  'isdark': false,
                  'speed': 120,
                  'fontsize': 14,
                });

                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed('/verify/');
              } on WeakPasswordAuthException {
                await showErrorDialog(
                    context, "Weak password, make it better!");
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                    context, "Email already in use, select a new one");
              } on InvalidEmailAuthException {
                await showErrorDialog(context, "This email is invalid");
              } on NetworkRequestFailedAuthException {
                await showErrorDialog(
                    context, "Check your internet connection please");
              } on GenericAuthException {
                await showErrorDialog(context, "Registration Error");
              }

              //Navigator.of(context).pushNamed('/choice/');
            },
            child: const Text('Connecter'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login/', (route) => false);
            },
            child: const Text("Already registred? Log in here"),
          ),
        ],
      ),
    );
  }
}
