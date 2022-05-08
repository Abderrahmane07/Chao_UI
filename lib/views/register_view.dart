import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tentative_chao_1/providers/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:tentative_chao_1/services/auth/auth_exceptions.dart';
import 'package:tentative_chao_1/services/auth/auth_service.dart';

import '../functions/error_dialog.dart';
import '../providers/our_font_size_provider.dart';
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
    int taille = Provider.of<OurFontSize>(context, listen: false).ourFontSize;
    return Scaffold(
      appBar: null,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            flex: 1,
            child: Image(
              image: NetworkImage(
                  'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi0uOAsc-Ughjqx0qoKU9XnadcegGFVcPOxSATV4m__Ib6AXpaT48cQBBtzU9xDy34hoZdU4taK-LH1oZSWNoyry9FRYN9fc-nahjV2NeB16CM_JDqm_1W-8f_A4rkbrCGsUoK4ZLDQGtyPxqylWQsgYeU8elGwGRKheNl2y1syv6JOxLMZDyHkFl0u/s16000/Homme_1.png'),
              //image: AssetImage('assets/Homme_1.png'),
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          ElevatedButton(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogin();
            },
            child: Text('Sign up with Google'),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              minimumSize: Size(200, 50),
            ),
          ),
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
                  'fontsize': taille,
                  'articles': {
                    'nbofcompletedarticles': 0,
                    'article': [
                      {},
                    ]
                  }
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
            child: const Text('Create account'),
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
