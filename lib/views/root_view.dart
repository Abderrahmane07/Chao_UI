import 'package:flutter/material.dart';
import 'package:tentative_chao_1/services/auth/auth_user.dart';
import 'package:tentative_chao_1/views/choice_view.dart';
import 'package:tentative_chao_1/views/login_view.dart';

import '../services/auth/auth_service.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class RootView extends StatefulWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final user = AuthService.firebase().currentUser;
    if (user != null) {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
// FirebaseUser _firebaseUser  =;
// AuthUser _currentUser = Provider.of<AuthUser>(context, listen:false);
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = LoginView();
        break;
      case AuthStatus.loggedIn:
        retVal = ChoiceView();
        break;
      default:
        retVal = Container();
    }

    return retVal;
  }
}
